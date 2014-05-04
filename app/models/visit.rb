class Visit < Sequel::Model

  def before_create
    set(:created_at => Time.now) 
  end

  def after_create
    set(:md5_hash => hash_value)
    save
  end

  def hash_value
    Digest::MD5.hexdigest(values.except(:md5_hash).to_s)
  end
end
