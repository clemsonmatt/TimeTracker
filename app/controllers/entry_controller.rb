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

    def pause
        @entry = Entry.find(params[:id])

        @entry.end    = DateTime.now
        @entry.status = 'paused'

        totalTime = @entry.total_time
        diffTime  = @entry.end - @entry.start

        if totalTime
            totalTime = totalTime + diffTime
        else
            totalTime = diffTime
        end

        totalTime = Time.at(totalTime).strftime "%H:%M:%S"

        @entry.total_time = totalTime
        @entry.save

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

        redirect_to person_path(@entry.person)
    end

    private
        def entry_params
            params.require(:entry).permit(:start, :end, :title, :description, :current)
        end
end
