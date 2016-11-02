class Entry < ApplicationRecord
    belongs_to :person

    validates :title, presence: true

    attr_accessor :current

    def active_time
        totalTime = self.total_time
        diffTime  = Time.now - self.start

        if totalTime
            totalTime = totalTime + diffTime
        else
            return self.start
        end

        totalTime = Time.at(totalTime).strftime "%H:%M:%S"
        totalTime = totalTime.split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}

        return Time.now - totalTime
    end
end
