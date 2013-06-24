enable :sessions
get '/' do
	erb :index
end

get '/oauth/connect' do
	redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get '/oauth/callback' do
	response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
	session[:access_token] = response.access_token
	redirect '/homepage'
end


get '/homepage' do
	erb :homepage
end

post '/homepage' do 
	user = Instagram.user_search("#{params[:username]}").pop
	redirect "/profile/#{user.username}"
end

get '/instapics' do
  @client = Instagram.client(:access_token => session[:access_token])
  erb :instapics
end
 

get '/profile/:username' do 
	@user = Instagram.user_search(params[:username]).pop
	erb :profile
end



