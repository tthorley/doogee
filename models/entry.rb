class Entry
  include DataMapper::Resource
  property :id,      Serial
  property :dated,   Date
  property :content, Text
end