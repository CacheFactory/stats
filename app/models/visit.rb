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

  def self.between_dates start_date, end_date
    Visit.filter('created_at > ? AND created_at < ?',  start_date, end_date)
  end
end
