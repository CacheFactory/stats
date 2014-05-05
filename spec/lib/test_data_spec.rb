require "spec_helper"

describe TestData do 
  
  it 'should create the correct number of rows' do
    amount_to_make = 100
    TestData.create_test_data amount_to_make
    Visit.all.count.should == amount_to_make
    
  end


  
end

describe TestData do 
  
  it 'should not create visits before 10 days ago' do
    amount_to_make = 100
    TestData.create_test_data amount_to_make
    Visit.filter('created_at < ? ', Time.now-10.days).count.should ==0
    
  end
end

