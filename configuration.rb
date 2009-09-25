require 'rubygems'
require 'dm-core'
require 'ferret'
include Ferret

# change these if you want to use some other file
# somewhere else for whatever reason
PATH = Dir.pwd
database_file = "/data/entries.db"
entries_model = "/models/entry.rb"

DataMapper.setup(:default, "sqlite3://" + PATH + database_file)
load PATH + entries_model

# useful methods
class Date
  def for_url
    self.strftime("%m-%d-%Y")
  end
  
  alias :for_index :for_url
  
  def for_entry
    self.strftime("%Y-%m-%d")
  end
  
  def self.from_params(params)
    Date.parse(params[:month]+"/"+params[:day]+"/"+params[:year])
  end
end

def entry_for(date)
  Entry.first(:day => date.for_entry)
end
