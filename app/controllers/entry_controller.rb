class EntryController < ApplicationController
    before_action :logged_in?

    def new
        # add method in entry.rb to find all entries for a user (does joins for clients and projects)
        @entries = Entry.all.where(person: @user).order(start: :desc).take(10)

        @entry = Entry.new
    end

    def create
        @entries = Entry.find_by(person: @user)

        @entry        = Entry.new(entry_params)
        @entry.person = @user
        @entry.status = 'created'

        if entry_params['current'] == '1'
            # set to the current datetime
            @entry.start = DateTime.now
        end

        if @entry.save
            redirect_to new_entry_path
        else
            render "new"
        end
    end

    def destroy
        entry  = Entry.find(params[:id])
        person = entry.person
        entry.destroy

        if params[:currentRoute] == 'entry'
            return redirect_to new_entry_path
        end

        redirect_to person_path(person)
    end

    def pause
        @entry = Entry.find(params[:id])

        @entry.end    = DateTime.now
        @entry.status = 'paused'

        totalTime = @entry.total_time
        diffTime  = @entry.end - @entry.start

        # get hours/mins/sec
        hours = (diffTime / 3600).to_i
        diffTime -= hours * 3600

        mins = (diffTime / 60).to_i
        diffTime -= mins * 60

        secs = diffTime.to_i

        # add to total time
        if totalTime
            totalTime = totalTime.split(':')
            hours += totalTime[0].to_i
            mins  += totalTime[1].to_i
            secs  += totalTime[2].to_i
        end

        hours = hours < 10 ? '0' + hours.to_s : hours
        mins  = mins < 10 ? '0' + mins.to_s : mins
        secs  = secs < 10 ? '0' + secs.to_s : secs

        totalTime = hours.to_s + ":" + mins.to_s + ":" + secs.to_s

        @entry.total_time = totalTime
        @entry.save

        if params[:currentRoute] == 'entry'
            return redirect_to new_entry_path
        end

        redirect_to person_path(@entry.person)
    end

    def status_change
        @entry        = Entry.find(params[:id])
        @entry.status = params[:status]

        if params[:status] == 'restart'
            @entry.start = DateTime.now
            @entry.end   = nil
        end

        @entry.save

        if params[:currentRoute] == 'entry'
            return redirect_to new_entry_path
        end

        redirect_to person_path(@entry.person)
    end

    private
        def entry_params
            params.require(:entry).permit(:start, :end, :title, :description, :current)
        end
end
