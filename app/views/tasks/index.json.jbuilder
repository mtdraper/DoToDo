json.array!(@tasks) do |task|
  json.extract! task, :id, :due_date, :completion_date, :label, :sync, :category_id
  json.url task_url(task, format: :json)
end
