require 'digest/md5'
require 'sinatra'
require 'data'
require 'haml'

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
    "try again"
  end
end

get '/admin' do
  erb :admin
end

post '/admin' do
  modelEntry = Models.create { :make => params[:make], :model => params[:model], :price => params[:price], :desc => params[:desc], :created_at => Time.now }

  customerEntry = Customers.new {
    fname: params[:fname],
    lname: params[:lname],
    passwd: params[:passwd]
  }
end
