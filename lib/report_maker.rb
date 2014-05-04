class ReportMaker
  DATE_FORMAT = "%Y-%m-%d"

  def self.top_urls

    get_visits_for_the_past_five_days do |visits,end_date, start_date,days_hash, days_ago|
      end_date =  (days_ago.days).ago
      start_date = (days_ago+1).days.ago
      
      visits_hash = {}
      Visit.between_dates( start_date, end_date).each do |visit|

        visits_hash[visit.url] = visits_hash[visit.url] || {'url' => visit.url, 'visits' => 0}
       
        visits_hash[visit.url]['visits'] = visits_hash[visit.url]['visits']+1
      end

      date_key = end_date.strftime(DATE_FORMAT)
      days_hash[date_key] = visits_hash.values

    end
   
    
  end

  def self.top_referrers

    get_visits_for_the_past_five_days do |visits,end_date, start_date,days_hash|
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
    

  end

  protected 

  def self.get_visits_for_the_past_five_days
    days_hash ={}
    5.times do |days_ago|
      end_date =  (days_ago.days).ago
      start_date = (days_ago+1).days.ago
      visits = Visit.between_dates start_date, end_date
      
      yield visits,end_date, start_date,days_hash, days_ago

    end
    
    days_hash
  end

  def self.top_by_attribute visits, top_amount, attribute
    url_hash={}
    visits.each do |visit|
      value =  url_hash[visit.send(attribute)] || []
      url_hash[visit.send(attribute)]=value.push(visit) 
    end
    sorted_visits = url_hash.sort_by {|key, value| -value.count}
    sorted_visits[0..top_amount]

  end

end