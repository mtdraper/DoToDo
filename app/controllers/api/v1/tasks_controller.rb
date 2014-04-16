module Api
  module V1
    class TasksController < ApplicationController
      
      respond_to :json
      
      
      def index
        
        #get all tasks for future filtering
        
        the_tasks = Task.all
        
        #get all tasks from the incoming ids
              
        duplicate_tasks = task_params[:ids]
        
        #get the :catid out of the url and in a variable  
        category_tasks = task_params[:catid]
        
        #get a list of non-duplicate tasks by filtering id
        not_duplicate = the_tasks.where.not(id: duplicate_tasks)
 
        #return with the non-duplicates filtered by catid
        respond_with not_duplicate.where(category_id: category_tasks)
        
        
      end
      
      def complete
        
        @task = Task.find(params[:id])
         
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