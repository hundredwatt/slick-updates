class Collaborator < ApplicationRecord

  belongs_to :update_form
  belongs_to :user
  
  validates :user_id, :update_form_id, presence: true
  validates :user_id, uniqueness: {scope: :update_form_id}
end
