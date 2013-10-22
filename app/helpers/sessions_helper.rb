module SessionsHelper
  def current_user
    @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def logged_in?
    !current_user.nil?
  end
	
	def logIn(user)
    cookies[:user_id] = user.id
  end
  
  def logOut(user)
    cookies.delete :user_id    
  end
	
end
