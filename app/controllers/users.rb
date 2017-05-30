# require 'geokit-rails'

#Main page
get '/' do 
	#DO NOT FORGET TO CHANGE REDIRECT TO MAINPAGE ERB
	erb :index

end

#Signup page
get '/users/new' do
	erb :"users/signup"
end

get '/users/:id' do 
	@user = User.find(params[:id])
	@posts = @user.posts
	erb :"/users/show"
end

#New user
post '/users' do
	@user = User.create(email: params[:email], username: params[:username], password: params[:password], profile_pic_url: params[:profile_pic_url])
	session[:user_id] = @user.id
	p @user
	redirect '/posts'
end

#Login page
get '/sessions/new' do
	p request.ip
	erb :"users/signin"
end

#Authenticate User and set new session
post '/sessions' do
	
	@user = User.find_by(username: params[:username])
	if @user && User.authenticate(params[:username],params[:password])
		session[:user_id] = @user.id
		p @user
		redirect "/posts"
	else
		@error = "Login failed, please try again."
		erb :"users/signin"
	end
end



#Logout and clear session
delete '/users/:id' do
	session.clear
	redirect '/'
end