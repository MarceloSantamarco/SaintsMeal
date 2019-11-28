class Customer < ApplicationRecord
    has_many :requests, dependent: :destroy
end
