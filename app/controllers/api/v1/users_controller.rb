module Api
  module V1
    class UsersController < ApplicationController
      before_filter :require_http_auth_user, :only => :login
      before_filter :restrict_access, :only => :logout
      
      respond_to :json
      
      def login
        @user = current_user
        respond_with @user.single_access_token
      end
      
      def logout
        #sets and saves a new single access token, forcing a login
        @user.single_access_token = @user.reset_single_access_token
        @user.save
        #responds by giving a 0 hopefully
        respond_with validate_token
      end
      
      def validate_token
        #set user object to the queried token user if exists
        @user = User.find_by_single_access_token(user_params[:token])
        #try catch block because I couldn't figure out a good conditional
        begin
          respond_with @user.id
        rescue
          respond_with 0
        end
      end    
           
      private
      
      def user_params
        params.permit(:format, :token)
      end  
      
      def require_http_auth_user
        authenticate_or_request_with_http_basic do |username, password|
          if user = User.find_by_username(username)
            user.valid_password?(password)
          else
            false
          end
        end
      end
      
      def restrict_access
          @user = User.find_by_single_access_token(user_params[:token])
          head :unauthorized unless @user
      end 
      
    end
  end
end      