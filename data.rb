require 'data_mapper'
#require 'dm-core'
#require 'dm-timestamps'
#require 'dm-validations'
#require 'dm-migrations'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/database.db"

class Models
  include DataMapper::Resource

  property :id          , Serial
  property :make        , String
  property :model       , String
  property :price       , Float
  property :created_at  , DateTime
  # property :desc        , Text
end

class Customers
  include DataMapper::Resource

  property :id          , Serial
  property :fname       , String
  property :lname       , String
  property :passwd      , String , :length => 18, lambda { |pass| Digest::MD5.hexdigest(pass) }
  property :created_at  , DateTime , :default => Time.now
end

Models.auto_upgrade!