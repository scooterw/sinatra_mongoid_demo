$:.push File.expand_path(File.join(File.dirname(__FILE__)))

require 'sinatra'
require 'multi_json'
require 'mongoid'

module MongoidDemo
  class Thing
    include Mongoid::Document

    field :name, type: String
    field :weight, type: Integer
  end

  Mongoid.load! 'config/mongoid.yml'
  
  class Server < Sinatra::Base
    env = ENV['RACK_ENV'] || 'development'

    configure :development do
      # for development only
    end

    configure :production do
      # for production only
    end

    configure do
      enable :logging
    end

    post '/things' do
      thing = MultiJson.load request.env['rack.input'].read
      @thing = Thing.create thing
      content_type :json
      MultiJson.dump @thing
    end
    
    get '/things' do
      @things = Thing.all
      content_type :json
      MultiJson.dump @things
    end

    get '/things/:id' do
      @thing = Thing.find(params[:id])
      content_type :json
      MultiJson.dump @thing
    end
  end
end
