class Tenant < ApplicationRecord
    has_many :apartments
    has_many :leases

    validates :name, presence: true
    validates :age, comparison: {greater_than_or_equal_to: 18}
end
