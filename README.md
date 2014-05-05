#Stats application prototype

A simple app that demonstrates using ROR without ActiveRecord, makes use of Sequel as its ORM and uses Angular.js to present JSON data.

###Rake tasks
===

creates the initial database
```
  $ rake create_database
```

deletes the database
```
  $ rake destroy_database
```

creates 1 million test data rows
```
  $ rake populate_test_data
```