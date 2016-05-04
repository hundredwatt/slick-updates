class User < ApplicationRecord
  has_many :update_forms
  
  has_many :collaborators
  has_many :invited_update_forms, through: :collaborators, source: :update_form
end
