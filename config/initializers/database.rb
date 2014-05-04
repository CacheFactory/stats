dbconfig    = YAML.load(File.read('config/database.yml'))
DB = Sequel.connect(dbconfig[Rails.env])
