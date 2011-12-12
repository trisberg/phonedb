require 'rubygems'
require 'digest/md5'
require 'sinatra'
require 'data_mapper'

## Global Variables

# none

### Database 

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.db")

class PhoneModels
  include DataMapper::Resource

  property :id          , Serial
  property :make        , String
  property :phone_model , String
  property :price       , String
  property :desc        , Text
  property :created_at  , DateTime , :default => Time.now
end

class Customers
  include DataMapper::Resource

  property :id          , Serial
  property :fname       , String , :required => true
  property :lname       , String , :required => true
  property :email       , String , :required => true , :format => :email_address
  property :passwd      , String , :length => 32 , :default => lambda { |pass, p| Digest::MD5.hexdigest(pass) }
  property :created_at  , DateTime , :default => Time.now, :default => lambda { |date, p| date.strftime("%d/%m/%Y") }

end
###/ End Database

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
  pmodel.attributes = { 
    :make => params[:make],
    :phone_model => params[:model],
    :price => params[:price],
#    :desc => params[:desc],
    :created_at => Time.now }
  pmodel.save

  person = Customers.new
  person.attributes = { :fname => params[:fname] , :lname => params[:lname], :email => params[:email], :passwd => params[:passwd], :created_at => Time.now }
  person.save

  redirect '/'
end

get '/models/:id' do
  @model = PhoneModels.get(params[:id])

  erb :model
end

get '/customers/:id' do
  @customer = Customers.get(params[:id])

  erb :customer
end

DataMapper.auto_upgrade!