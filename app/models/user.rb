class User < ApplicationRecord
  has_many :update_forms
  
  has_many :collaborators
  has_many :invited_update_forms, through: :collaborators, source: :update_form
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

end
