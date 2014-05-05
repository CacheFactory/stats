require "spec_helper"

describe ReportMaker do 
  before(:all) do
    @visit_1 =Visit.new(:url => 'http://apple.com', :referrer => 'http://apple.com').save
    @visit_2 =Visit.new(:url => 'http://apple.com', :referrer => 'http://apple.com').save
    @visit_3 =Visit.new(:url => 'https://apple.com', :referrer => 'http://apple.com').save
    @visit_4 =Visit.new(:url => 'https://apple.com4', :referrer => 'http://apple.com4').save
    @visit_5 =Visit.new(:url => 'https://apple.com5', :referrer => 'http://apple.com5').save
    @visit_6 =Visit.new(:url => 'https://apple.com6', :referrer => 'http://apple.com6').save
    @visit_7 =Visit.new(:url => 'https://apple.com7', :referrer => 'http://apple.com7').save
  end
  
  it 'should show the top urls correctly' do
    report = ReportMaker.top_urls

    report[@visit_1.created_at.strftime(ReportMaker::DATE_FORMAT) ].include?({:url=>"http://apple.com", :visits=>2}).should ==true

    report[@visit_1.created_at.strftime(ReportMaker::DATE_FORMAT) ].include?({:url=>"https://apple.com", :visits=>1}).should ==true
    report.count.should==5
    report[@visit_1.created_at.strftime(ReportMaker::DATE_FORMAT) ].count.should ==5

    report[@visit_1.created_at.strftime(ReportMaker::DATE_FORMAT) ].first[:url].should == 'http://apple.com'

  end

  it 'should calculate the top urls' do
    top_urls = ReportMaker.send('top_by_attribute', Visit.all, 1, 'url')
    top_urls.first.first.should == 'http://apple.com'
  end

  it 'should show the top referrers correctly' do
    report = ReportMaker.top_referrers
    report[@visit_1.created_at.strftime(ReportMaker::DATE_FORMAT)].include?({ :url => 'http://apple.com', 
                                                                                :visits => 2,  
                                                                                :referrers => [ { :url => 'http://apple.com', :visits => 2 } ]} ).should ==true
    report.count.should==5                                                                       
                                                                              
    
  end

  
end