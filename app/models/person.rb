class Person < ApplicationRecord
    has_many :entries, dependent: :destroy
    has_many :projects, dependent: :destroy

    def to_s
        "#{self.first_name} #{self.last_name}"
    end

    has_secure_password

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
end
