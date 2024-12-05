# frozen_string_literal: true

class Api::V1::StudyClassesController < ApplicationController
  def index
    @school = School.find(params[:school_id])
    render json: { study_class: @school.study_classes }
  end
end
