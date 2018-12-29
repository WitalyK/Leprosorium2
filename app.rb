#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, "sqlite3:leprosorium2.db"

class Posts < ActiveRecord::Base #создание таблицы (сущности)
	validates :name, presence: true
	validates :content, presence: true
end

class Comments  < ActiveRecord::Base #создание таблицы (сущности)
	validates :content, presence: true
end


before do #прикаждом вызове
  @comments = Comments.all
end

get '/' do
	@results = Posts.order('created_at DESC')
	erb :index			
end

get '/new' do
  erb :new
end

post '/new' do
	@c = Posts.new params[:posts]
    if !@c.save
       	@error = @c.errors.full_messages[0]
    	return erb :new
    end
    redirect to '/'
end

get '/details/:post_id' do
	post_id = params[:post_id]
	@row = Posts.find(post_id)
	@comments = Comments.find_by post_id: post_id
	erb :details
end

post '/details/:post_id' do
	post_id = params[:post_id]
    content = params[:content]
    if content.length <= 0
		@error = 'Type comment text'
		return redirect to ('/details/' + post_id)
	end
    @db.execute 'insert into Comments (content, Created_date, post_id) values (?, datetime(), ?)', [content, post_id]

    redirect to ('/details/' + post_id) 
end
