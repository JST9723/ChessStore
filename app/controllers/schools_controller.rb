class SchoolsController < ApplicationController
  before_action :set_school,[:show, :edit, :update]
  before_action :check_login

  def index
    @schools = School.active.alphabetical
    @inactive_schools = School.inactive.alphabetical
  end


  def new
    @school = School.new
  end

  def show
  end

  # def edit
  # end
  #
  # def create
  # end

  private
  def set_school
    @school = School.find(params[:id])
  end


end
