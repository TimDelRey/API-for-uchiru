# frozen_string_literal: true

class StudentsController < ApplicationController
  include ActionController::Cookies

  before_action :authenticate_student, only: [:destroy]

  def index # добавить валидацию не существующих студентов
    @school = School.find(params[:school_id])
    @study_class = StudyClass.find(params[:study_class_id])
    @students = @study_class.students
    render json: @students, status: 201
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      # cookies[:auth_token] = { value: @student.auth_token,
      #                         httponly: true, # защита от JS
      #                         same_site: :lax } # защита CSR

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
      render plain: 'Некорректный id студента', status: 400
    end
  end
  
  private

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
      render plain: 'Некорректная авторизация', status: 401
    end
  end

  def valid_token?(token)
    Student.exists?(auth_token: token)
  end
end
