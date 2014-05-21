#Stats application prototype

A simple app that demonstrates using ROR without ActiveRecord, makes use of Sequel as its ORM and uses Angular.js to present JSON data.

###Setup
You will need to create a mysql database and add its connection infor toe config/database.yml

###Rake tasks
===

creates the initial database
```
  $ rake create_tables
```

deletes the database
```
  $ rake destroy_tabels
```

creates 1 million test data rows
```
  $ rake populate_test_data
```