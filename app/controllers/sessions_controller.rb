class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user
      session_userid(user.id)
      flash[:notice] = notify(:logged_in)
      if session_original_url
        url = session_original_url
        session_original_url(nil)
        redirect_to url and return
      end
      redirect_to root_url
    end
  end

  def delete
    session_userid(nil)
    redirect_to root_url, notice:notify(:logged_out)
  end
end
