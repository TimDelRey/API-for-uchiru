# frozen_string_literal: true

class StudyClassesController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    render json: @school.study_classes, status: 201
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Школа не найдена' }, status: :not_found
  end
end
