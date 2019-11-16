class Table < ApplicationRecord
    has_many :requests
    has_one :waiter
    has_one :customer
end
