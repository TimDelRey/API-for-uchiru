# frozen_string_literal: true

class StudyClassesController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    render json: @school.study_classes, status: 201
  end
end
