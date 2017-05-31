require 'sendgrid-ruby'
require 'dotenv'
include SendGrid
Dotenv.load

get '/posts' do 
	if(session[:user_id])
		@user_id = session[:user_id]
		@user = User.find(@user_id)
		@posts = Post.all
		erb :"posts/posts"
	else
		redirect '/sessions/new'
	end
end

get '/posts/new' do
	if(session[:user_id])
		erb :"posts/new"
	else
		redirect '/sessions/new'
	end
end

post '/posts' do
	@post = Post.create(post_body: params[:body], post_img_url: params[:imgurl],user_id: session[:user_id])
	redirect '/posts'
end

get '/posts/:id' do
	@post = Post.find(params[:id])
	erb :"/posts/show"
end

get '/posts/:id/edit' do
	if(!session[:user_id])
		redirect "/sessions/new"
	end
	@post = Post.find(params[:id])
	erb :"posts/edit"
end

patch '/posts/:id' do 
	@post = Post.find(params[:id])
	@post.update(post_body: params[:body], post_img_url: params[:url])
	redirect '/posts'
end

delete '/posts/:id' do
	Post.find(params[:id]).destroy
	redirect '/posts'
end

post '/likes/:id' do
	@like = Like.create(post_id: params[:id].to_i, user_id: session[:user_id].to_i)
	@receiver_email = User.find(Post.find(params[:id].to_i).user_id).email
	@from = Email.new(email: User.find(session[:user_id].to_i).email)
	@to = Email.new(email: @receiver_email)
	@subject = 'BURD NOTIFICATION: A user liked your post!'
	@content = Content.new(type: 'text/plain', value: User.find(session[:user_id].to_i).username+' liked your post')
	@mail = Mail.new(@from, @subject, @to, @content)
	@sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
	@response = @sg.client.mail._('send').post(request_body: @mail.to_json)
	redirect '/posts'
end

post '/comments/:id' do
	@comment = Comment.create(post_id: params[:id].to_i, user_id: session[:user_id].to_i, comment_body: params[:body])
	@like = Like.create(post_id: params[:id].to_i, user_id: session[:user_id].to_i)
	@receiver_email = User.find(Post.find(params[:id].to_i).user_id).email
	@from = Email.new(email: User.find(session[:user_id].to_i).email)
	@to = Email.new(email: @receiver_email)
	@subject = 'BURD NOTIFICATION: A user commented on your post!'
	@content = Content.new(type: 'text/plain', value: User.find(session[:user_id].to_i).username+' commented on your post')
	@mail = Mail.new(@from, @subject, @to, @content)
	@sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
	@response = @sg.client.mail._('send').post(request_body: @mail.to_json)
	redirect '/posts'
end






