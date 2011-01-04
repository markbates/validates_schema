require 'active_record'
ActiveRecord::Base.logger = Logger.new('/tmp/dj.log')
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '/tmp/jobs.sqlite')
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.default_timezone = :utc

ActiveRecord::Schema.define do

  create_table :users, :force => true do |t|
    t.string :name, :limit => 200
    t.string :email
    t.string :password, :null => false
    t.string :url, :limit => 128, :null => false
    t.integer :age
    t.integer :pin, :limit => 8, :null => false
    t.float :salt
    t.text :bio
    t.text :summary, :null => false
    t.boolean :alive, :null => false
    t.decimal :salary, :null => false, :precision => 2, :scale => 8
    t.timestamps
  end
  
  create_table :artists, :force => true do |t|
    t.timestamps
  end

end