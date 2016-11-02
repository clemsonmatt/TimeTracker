class Entry < ApplicationRecord
    belongs_to :person

    validates :title, presence: true

    attr_accessor :current
end
