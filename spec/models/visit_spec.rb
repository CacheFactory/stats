require "spec_helper"

describe Visit do 

  
  it 'should save correctly' do
    url = 'http://apple.com'

    create_hash = {url: url,
                   referrer: url}
    visit = Visit.new create_hash
    visit.save

    visit.url.should == url
    visit.referrer.should == url
    visit.created_at.should_not == nil
    visit.md5_hash.length.should == 32
    
  end

  
end