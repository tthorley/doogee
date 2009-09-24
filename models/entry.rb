class Entry
  include DataMapper::Resource
  property :id,      Serial
  property :day,     Date
  property :content, Text
end