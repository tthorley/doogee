class Entry
  include DataMapper::Resource
  property :id,        Serial
  property :datestamp, DateTime
  property :content,   Text
end