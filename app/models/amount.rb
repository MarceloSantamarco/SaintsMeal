class Amount < ApplicationRecord
    belongs_to :request
    has_many :items
end
