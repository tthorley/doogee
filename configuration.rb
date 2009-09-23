require 'rubygems'
require 'dm-core'
require 'ferret'

# change these if you want to use some other file
# somewhere else for whatever reason
PATH = Dir.pwd
database_file = "/data/entries.db"
entries_model = "/models/entry.rb"

DataMapper.setup(:default, "sqlite3://" + PATH + database_file)
load PATH + entries_model

