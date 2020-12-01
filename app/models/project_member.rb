class ProjectMember < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project
end
