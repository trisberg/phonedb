require 'rubygems'
require 'bundler'
require 'sinatra'
require './main'

Bundler.require

run Sinatra::Application