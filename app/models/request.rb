class Request < ApplicationRecord
    belongs_to :customer
    has_many :amounts, dependent: :destroy
end
