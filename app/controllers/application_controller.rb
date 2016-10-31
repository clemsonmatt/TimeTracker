class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    private

    def logged_in?
        @user ||= Person.find(session[:user_id]) if session[:user_id]

        if ! @user
            redirect_to new_session_path
        end
    end

    helper_method :logged_in?
end
