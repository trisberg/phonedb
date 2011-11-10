require 'sinatra'
require 'haml'


get '/' do
  haml :index
end

get '/hello/:name' do
  "Hello #{params[:name]}!"
end

get '/about' do
  haml  :index
end

get '/form' do
  erb :form
end

#  config = {
#    :urls => { :url_github => 'https://github.com/' }
#    github: [
#      user: 'pixelwolf', :repos = { 
#        :coffeh  => { :name => 'coffeh'     , :url => 'https://github.com/pixelwolf/coffeh/'      , :forked => false  },
#        :vimrc   => { :name => 'vimrc'      , :url => 'https://github.com/pixelwolf/vimrc/'       , :forked => false  },
#        :lesscss => { :name => 'lesscss.org', :url => 'https://github.com/pixelwolf/lesscss.org/' , :forked => true   }
#      }
#    ]
#  }
