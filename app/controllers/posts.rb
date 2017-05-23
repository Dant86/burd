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
end

post '/comments/:id' do
	@comment = Comment.create(post_id: params[:id].to_i, user_id: session[:user_id].to_i, comment_body: params[:body])
end






