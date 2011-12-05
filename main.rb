require 'rubygems'
require 'digest/md5'
require 'sinatra'
require 'haml'
require 'data_mapper'

DataMapper.setup :default, "sqlite3://#{Dir.pwd}/database.db"

class PhoneModels
  include DataMapper::Resource

  property :id          , Serial
  property :make        , String
  property :phone_model , String
  property :price       , Float
  property :desc        , Text
  property :created_at  , DateTime
end

class Customers
  include DataMapper::Resource

  property :id          , Serial
  property :fname       , String
  property :lname       , String
  property :email       , String , :format => :email_address
  property :passwd      , String , :length => 18, :default => lambda { |pass| Digest::MD5.hexdigest(pass) }
  property :created_at  , DateTime , :default => Time.now
end

PhoneModels.auto_upgrade!
Customers.auto_upgrade!

get '/' do
	erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  if params[:user] == "admin" && params[:passwd] == "password"
    redirect '/admin'
  else
    "Try Again"
  end
end

get '/admin' do
  @models = PhoneModels.all :order => :id
  @customers = Customers.all :order => :id
  erb :admin
end


# post '/admin' do
#   modelEntry = Models.create { 
#     :make       => params[:make], 
#     :phone_model      => params[:model], 
#     :price      => params[:price], 
#     :desc       =>  params[:desc], 
#     :created_at => Time.now }

#   customerEntry = Customers.new {
#     fname: params[:fname],
#     lname: params[:lname],
#     passwd: params[:passwd]
#   }
# end

post '/admin' do
  pmodel = PhoneModels.new
  pmodel.attributes = { :make => params[:make] , :phone_model => params[:model], :price => params[:price], :desc => params[:desc], :created_at => Time.now }
  pmodel.save
end