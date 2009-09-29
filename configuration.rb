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

# useful methods for dates
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

#useful methods for ferret indexing
def get_ferret_index
  Index::Index.new(:path => './data/search-indexes')
end

module Ferret
  module Index
    class Index
      def add_entry(entry)
        self << {:entry_id => entry.id, :date => entry.day.for_index, :content => entry.content}
      end
      
      def delete_entry_with_id(entry_id)
        index_id = nil
        self.search_each('entry_id:"'+entry_id.to_s+'"') {|id| index_id = id}
        self.delete(index_id) if index_id
      end
    end
  end
end