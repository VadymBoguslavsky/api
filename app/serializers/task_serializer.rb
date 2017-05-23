class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :priority, :completed, :due_date, :updated_at
end
