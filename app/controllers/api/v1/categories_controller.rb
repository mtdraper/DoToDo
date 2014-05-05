module Api
  module V1
    class CategoriesController < ApplicationController
      
      before_filter :restrict_access
      
      respond_to :json
      
      
      def index
        
        #get all categories from the incoming ids
        
        duplicate_category = category_params[:ids]
        
        #get a list of categories not in the incoming ids for this user 
        category_all = @user.categories
        
        #return with the categories filtered by category that are not duplicates
        respond_with category_all.where.not(id: duplicate_category) 
        
      end
      
      def create
        #new category
        @category = Category.new
        #fill the needed variables
        @category.label = category_params[:label]
        @category.user_id = @user.id
        
        #try to save it, and if saved respond with the object
        if @category.save
          respond_with @category
        else
          respond_with @category.errors status: :unprocessable_entity
        end 
      end
      
      #errors to catch
      rescue_from ActionController::UnknownFormat do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end  
      
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end      
      
      private
      
        def category_params
          params.permit(:format, { ids: []}, :token, :label)
        end   
        
        def restrict_access
          @user = User.find_by_single_access_token(category_params[:token])
          head :unauthorized unless @user
        end 
      
    end
  end
end