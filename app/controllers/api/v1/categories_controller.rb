module Api
  module V1
    class CategoriesController < ApplicationController
      
      
      respond_to :json
      
      
      def index
        
        #get all tasks from the incoming ids
        
        duplicate_category = category_params[:ids]
        
        #get a list of tasks not in the incoming ids   
        category_all = Task.all
        
        #return with the tasks filtered by category that are not duplicates
        respond_with category_all.where.not(id: duplicate_category) 
        
      end
      
      rescue_from ActionController::UnknownFormat do |e|
        render json: {error: e.message!}.to_json, status: :not_acceptable
      end  
      
      
      private
      
        def category_params
          params.permit(:format, {ids: []})
        end    
      
    end
  end
end