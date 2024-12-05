class StudentsController < ApplicationController

  def index # добавить валидацию не существующих студентов
    @school = School.find(params[:school_id]) # ненужный параметр
    @study_class = StudyClass.find(params[:study_class_id])
    @students = @study_class.students
    render json: @students, status: 201
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student, status: 201
    else
      render :new
    end
  end

  def destroy
    render json: @student.study_class if @student = Student.find(params[:id]).destroy
  end

  private

  def student_params
    params.require(:student).permit(:first_name, 
                                    :last_name, 
                                    :surname, 
                                    :school_id, 
                                    :study_class_id)
  end
end
