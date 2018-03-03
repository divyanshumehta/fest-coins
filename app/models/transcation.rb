class Transcation < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
