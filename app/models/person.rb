class Person < ApplicationRecord
    def to_s
        "#{self.first_name} #{self.last_name}"
    end

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
end
