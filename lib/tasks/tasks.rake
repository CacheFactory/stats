desc "create the database"
task :create_tables  => [:environment] do
   DB.create_table :visits do
    primary_key :id
    String :url
    String :referrer
    Datetime :created_at
    String :md5_hash
  end
end

desc "destroy the database"
task :destroy_tables  => [:environment] do
  if DB.table_exists? :visits
    DB.drop_table :visits
  end
end

desc 'populate test data'
task :populate_test_data  => [:environment] do
  TestData.create_test_data 1000000

end
