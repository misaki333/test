class Plan < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :destinations, inverse_of: :plan
  accepts_nested_attributes_for :destinations, allow_destroy: true

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
