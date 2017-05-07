class SchoolsController < ApplicationController

  before_action :check_login

  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create

  end


end
