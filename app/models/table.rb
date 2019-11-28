class Table < ApplicationRecord
    has_many :requests, dependent: :destroy
    has_one :waiter
    has_one :customer
end
