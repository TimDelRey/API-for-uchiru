# frozen_string_literal: true

class StudentsController < ApplicationController
  include ActionController::Cookies

  before_action :authenticate_student, only: [:destroy]
  before_action :set_school, only: [:index]
  before_action :set_class, only: [:index]

  def index
    @students = @study_class.students
    render json: @students, status: 201
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student, status: 201
      response.set_header('X-Auth-Token', @student.auth_token)
    else
      render json: { error: @student.errors.full_messages }, status: 405
    end
  end

  def destroy
    @student = Student.find_by(id: params[:id])
  
    if @student.present?
      @student.destroy
      render json: @student.study_class
    else
      render json: { message: 'Некорректный id студента' }, status: 400
    end
  end
  
  private

  def set_school
    @school = School.find(params[:school_id])
  rescue ActiveRecord::RecordNotFound
      render json: { message: 'Школа не найдена' }, status: :not_found
  end

  def set_class
    @study_class = StudyClass.find(params[:study_class_id])
  rescue ActiveRecord::RecordNotFound
      render json: { message: 'Класс не найдена' }, status: :not_found
  end

  def student_params
    params.require(:student).permit(:first_name,
                                    :last_name,
                                    :surname,
                                    :school_id,
                                    :study_class_id)
  end

  def authenticate_student
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last

    unless valid_token?(token)
      render json: { message: 'Некорректная авторизация' }, status: 401
    end
  end

  def valid_token?(token)
    Student.exists?(auth_token: token)
  end
end
