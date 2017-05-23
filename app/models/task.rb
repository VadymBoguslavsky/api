class Task < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true,length: { minimum: 2 }
  validates :priority, presence: true,numericality: { only_integer: true }
  belongs_to :user
end
