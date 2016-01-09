class UpdateForm < ApplicationRecord
  has_many :questions

  has_secure_token
end
