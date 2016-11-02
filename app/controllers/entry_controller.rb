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

    private
        def entry_params
            params.require(:entry).permit(:start, :end, :title, :description, :current)
        end
end
