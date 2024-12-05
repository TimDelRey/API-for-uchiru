class Api::V1::StudentsController < ApplicationController

  def index
    @school = School.find(params[:school_id]) # ненужный параметр
    @study_class = StudyCLass(find(params[:class_id]))
    @students = @study_class.students
  end

  def new
  end

  def create
  end

  def destroy
  end

end
