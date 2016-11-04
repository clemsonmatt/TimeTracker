class Entry < ApplicationRecord
    belongs_to :person

    validates :title, presence: true

    attr_accessor :current

    def active_time
        if self.start == nil
            # not started yet
            return '00:00:00'
        end

        totalTime = self.total_time
        diffTime  = Time.now - self.start

        if totalTime == nil
            return self.start
        end

        totalTime = totalTime.split(':')
        hours = totalTime[0].to_i
        mins  = totalTime[1].to_i
        secs  = totalTime[2].to_i

        totalSecs = (hours * 3600) + (mins * 60) + secs

        return Time.now - totalSecs
    end
end
