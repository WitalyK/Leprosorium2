#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, "sqlite3:leprosorium2.db"

class Posts < ActiveRecord::Base #создание таблицы (сущности)
end

class Comments  < ActiveRecord::Base #создание таблицы (сущности)
end


before do #прикаждом вызове
  # @ = base.all
end

get '/' do
	erb "Hello!"			
end