# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHelper
  include RenderHelper

  rescue_from ActionController::ParameterMissing, ActionController::UnpermittedParameters, with: :exception_params
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_exception
end
