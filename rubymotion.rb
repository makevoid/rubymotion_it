# encoding: utf-8

path = File.expand_path '../', __FILE__
PATH = path

require "#{path}/config/env.rb"


class Rubymotion < Sinatra::Base

  get "/" do
    @posts = Post.all
    haml :index
  end

  get "/posts/*" do |id|
    @post = Post.match id
    haml :post
  end


  include Voidtools::Sinatra::ViewHelpers

  # partial :comment, { comment: "blah" }
  # partial :comment, comment

  def partial(name, value)
    locals = if value.is_a? Hash
      value
    else
      hash = {}; hash[name] = value
      hash
    end
    haml "_#{name}".to_sym, locals: locals
  end
end

require_all "#{path}/routes"