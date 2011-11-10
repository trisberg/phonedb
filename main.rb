require 'sinatra'
include 'data.rb'
require 'haml'

get '/' do
	erb :models
end

get '/models' do
	erb :models
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
  entry       = models.new
  entry.make  = params[:make]
  entry.model = params[:model]
  entry.price = params[:price]
end
