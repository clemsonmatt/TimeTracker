class Project < ApplicationRecord
    belongs_to :person
    has_many :entries, dependent: :destroy

    validates :title, presence: true

    def to_s
        "#{self.title}"
    end
end
