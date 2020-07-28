class Project < ApplicationRecord
  # belongs_to :country, optional: true
  # has_one :area
  has_many :users, through: :user_projects
  has_many :user_projects
  accepts_nested_attributes_for :user_projects, allow_destroy: true
end
