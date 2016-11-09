class EntryController < ApplicationController
    before_action :logged_in?

    def new
        @entries  = all_entries
        @projects = all_projects

        @entry = Entry.new
    end

    def edit
        @entries  = all_entries
        @projects = all_projects
        @entry    = Entry.find(params[:id])
    end

    def create
        @entries  = all_entries
        @projects = all_projects

        @entry        = Entry.new(entry_params)
        @entry.person = @user
        @entry.status = 'created'

        if entry_params['current']
            @entry.status = 'active'
        end

        if entry_params['complete'] == '1'
            # mark as paused since completed
            @entry.status = 'paused'
        else
            @entry.start = DateTime.now
        end

        if @entry.save
            redirect_to new_entry_path
        else
            render "new"
        end
    end

    def update
        @entries  = all_entries
        @projects = all_projects

        @entry = Entry.find(params[:id])

        if @entry.update(entry_params)
            redirect_to new_entry_path
        else
            render "edit"
        end
    end

    def destroy
        entry   = Entry.find(params[:id])
        person  = entry.person
        project = entry.project
        entry.destroy

        if params[:currentRoute] == 'entry'
            return redirect_to new_entry_path
        elsif params[:currentRoute] == 'project'
            return redirect_to project_path(project)
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

        if secs > 59
            mins += secs / 59
            secs = secs % 59
        end
        if mins > 59
            hours += mins / 59
            mins = mins % 59
        end

        hours = hours < 10 ? '0' + hours.to_s : hours
        mins  = mins < 10 ? '0' + mins.to_s : mins
        secs  = secs < 10 ? '0' + secs.to_s : secs

        totalTime = hours.to_s + ":" + mins.to_s + ":" + secs.to_s

        @entry.total_time = totalTime
        @entry.save

        if params[:currentRoute] == 'entry'
            return redirect_to new_entry_path
        elsif params[:currentRoute] == 'project'
            return redirect_to project_path(@entry.project)
        end

        redirect_to person_path(@entry.person)
    end

    def status_change
        @entry        = Entry.find(params[:id])
        @entry.status = params[:status]

        if params[:status] == 'active'
            @entry.start = DateTime.now
            @entry.end   = nil
        end

        @entry.save

        if params[:currentRoute] == 'entry'
            return redirect_to new_entry_path
        elsif params[:currentRoute] == 'project'
            return redirect_to project_path(@entry.project)
        end

        redirect_to person_path(@entry.person)
    end

    private
        def entry_params
            params.require(:entry).permit(:start, :end, :title, :description, :current, :complete, :total_time, :project_id)
        end

        def all_entries
            # add method in entry.rb to find all entries for a user (does joins for clients and projects)
            Entry.all.where(person: @user).order(start: :desc).take(10)
        end

        def all_projects
            Project.all.where(person: @user).order(created_at: :desc).take(10)
        end
end
