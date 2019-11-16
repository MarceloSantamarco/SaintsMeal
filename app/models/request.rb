class Request < ApplicationRecord
    has_one :customer
    has_many :amounts
end
