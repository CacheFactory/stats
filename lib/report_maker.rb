class ReportMaker
  DATE_FORMAT = "%Y-%m-%d"

  def self.top_urls
    days_hash ={}
    Visit.filter('created_at > ?',  5.days.ago).each do |visit|
      date_key = visit.created_at.strftime(DATE_FORMAT)
      days_hash[date_key] = days_hash[date_key] || {}
     
      days_hash[date_key][visit.url] = days_hash[date_key][visit.url] || {'url' => visit.url, 'visits' => 0}
     
      days_hash[date_key][visit.url]['visits'] = days_hash[date_key][visit.url]['visits']+1
    end

    days_hash.each do |key,value|
      days_hash[key]=value.values
    end
    
  end

  def self.top_referrers
    days_hash ={}
    5.times do |days_ago|
      end_date =  (days_ago.days).ago
      start_date = (days_ago+1).days.ago
      visits = Visit.filter('created_at > ? AND created_at < ?',  start_date, end_date)
      
      date_key = end_date.strftime(DATE_FORMAT)
      days_hash[date_key]=top_by_attribute(visits, 10, 'url').collect do |top_visit|
        {
          url: top_visit[0],
          visits: top_visit[1].length,
          referrers: top_by_attribute(top_visit[1], 5,'referrer').collect do |top_referrer|
            {
              url: top_referrer[0],
              visits: top_referrer[1].length
            }
          end
        }
      end

    end
    
    days_hash
    

  end

  protected 

  def self.top_by_attribute visits, top_amount, attribute
    url_hash={}
    visits.each do |visit|
      value =  url_hash[visit.send(attribute)] || []
      url_hash[visit.send(attribute)]=value.push(visit) 
    end
    sorted_visits = url_hash.sort_by {|key, value| value.count}
    sorted_visits[0..top_amount]

  end

end