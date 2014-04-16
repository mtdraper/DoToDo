module Api
  module V1
    class TasksController < ApplicationController
      
      respond_to :json
      
      
      def index
        
        #get all tasks from the incoming ids
        
        duplicate_tasks = task_params[:ids]
        
        #get a list of tasks not in the incoming ids   
        category_tasks = Task.where(:catid == Task.category_id)
        
        #return with the tasks filtered by category that are not duplicates
        respond_with category_tasks.where.not(id: duplicate_tasks) 
        
      end
      
      def complete
        
        @task = Item.find(params[:id])
         
        @task.completion_date = Time.zone.now
        if @task.save
          respond_with @task
        else
          respond_with @item.errors status: :unprocessable_entity
        end
             
      end
      
      
      rescue_from ActionController::UnknownFormat do |e|
        render json: {error: e.message!}.to_json, status: :not_acceptable
      end
      
      private
      
        def task_params
          params.permit(:catid, :format, {ids: []})
        end
      
      
    end
  end
end