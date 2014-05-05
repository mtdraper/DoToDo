module Api
  module V1
    class TasksController < ApplicationController
      
      before_filter :restrict_access
      
      respond_to :json
      
      
      def index
        
        #get all tasks of the user for future filtering
        
        the_tasks = @user.tasks
        
        #get all tasks from the incoming ids
              
        duplicate_tasks = task_params[:ids]
        
        #filter for duplicates        
        not_duplicate = the_tasks.where.not(id: duplicate_tasks)
        
        #get the :catid out of the url and in a variable to return if there, else return all not duplicates 
        if task_params[:catid]
          category_tasks = task_params[:catid]
          respond_with not_duplicate.where(category_id: category_tasks)
        else
          respond_with not_duplicate
        end
        
        
      end
      
      def create
        sought_category = task_params[:catid]
        @category = @user.categories.find(sought_category)
        #@category = Category.find(sought_category)
        @task = Task.new
        
        @task.category_id = @category.id
        @task.label = task_params[:label]
        if @task.save
          respond_with @task
        else
          respond_with @task.errors status: :unprocessable_entity
        end     
      end
      
      def complete
        
        @task = @user.tasks.find(params[:id])
        #@task = Task.find(params[:id])
         
        @task.completion_date = Time.zone.now
        if @task.save
          respond_with @task
        else
          respond_with @task.errors status: :unprocessable_entity
        end
             
      end      
      
      rescue_from ActionController::UnknownFormat do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end
      
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end
      
      private
      
        def task_params
          params.permit(:catid, :format, {ids: []}, :token, :label)
        end
        
        def restrict_access
          @user = User.find_by_single_access_token(task_params[:token])
          head :unauthorized unless @user
        end
      
      
    end
  end
end