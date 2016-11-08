class ProjectController < ApplicationController
    before_action :logged_in?

    def show
        @project = Project.find(params[:id])
    end

    def new
        @projects = all_projects
        @project  = Project.new
    end

    def edit
        @projects = all_projects
        @project  = Project.find(params[:id])
    end

    def create
        @projects = all_projects

        @project        = Project.new(project_params)
        @project.person = @user
        @project.status = 'active'

        if @project.save
            redirect_to new_project_path
        else
            render 'new'
        end
    end

    def update
        @projects = all_projects
        @project  = Project.find(params[:id])

        if @project.update(project_params)
            redirect_to project_path(@project)
        else
            render 'edit'
        end
    end

    private
        def project_params
            params.require(:project).permit(:title, :description)
        end

        def all_projects
            Project.all.where(person: @user).order(created_at: :desc).take(10)
        end
end
