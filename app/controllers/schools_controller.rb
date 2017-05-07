class SchoolsController < ApplicationController
  before_action :set_school, only: [:show,:edit, :update,:destroy]
  before_action :check_login

  def index
    @schools = School.active.alphabetical
    @inactive_schools = School.inactive.alphabetical
  end


  def new
    @school = School.new
  end

  def show
    authorize! :show, @school
  end

  def edit
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to school_path(@school), notice: "Successfully created #{@school.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @school.update_attributes(school_params)
      redirect_to school_path(@school), notice: "Successfully updated #{@school.name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @school.destroy
    redirect_to schools_path, notice: "Successfully removed #{@school.name} from the system."
  end

  private
  def set_school
    @school = School.find(params[:id])
  end

  def school_params
      params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :active)
  end


end
