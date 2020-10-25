#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:leprosorium.db"
class Post  < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :content, presence: true, length: {minimum: 1}
end

class Comment < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :content, presence: true, length: {minimum: 1}
end

before do
	@posts = Post.all


end

get '/' do
	erb :index
end

get '/new' do
	@p = Post.new
	erb :new
end

post '/new' do
	@p = Post.new params[:post]
	if @p.save
		erb "<h2>Спасибо, Вы создали новый пост!</h2>"
	else
		@error =@p.errors.full_messages.first
		erb redirect to '/'
	end
end

get '/details/:post_id' do
	@post = Post.find(params[:post_id])
	@comments = Comment.where(post_id: @post.id)
	erb :details
end

post '/details/:post_id' do
	@post = Post.find(params[:post_id])
	@comments = Comment.where(post_id: @post.id)
  @c = Comment.new params[:comment]
  @c.post_id = @post.id
	if @c.save
		erb "<h2>Спасибо, Вы создали новый комментарий!</h2>"
	else
		@error =@c.errors.full_messages.first
	end
	erb :details
end