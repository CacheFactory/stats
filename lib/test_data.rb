class TestData
  def self.create_test_data rows
    urls = ['http://apple.com', 'https://apple.com', 'https://www.apple.com', 'http://developer.apple.com', 'http://en.wikipedia.org', 'http://opensource.org']
    referrers = urls + [nil]
    date_1 = Time.now
    date_2 = date_1-10.days
    
    rows.times do 
      create_hash = {url: urls.sample, referrer: referrers.sample}
      visit= Visit.new create_hash
      visit.save

      visit.created_at= Time.at((date_2.to_f - date_1.to_f)*rand + date_1.to_f)
      visit.save

    end

  end

end