module ExceptionHelper

  def exception_params(e)
    render json: { message: "#{e.message}", status: :bad_request } and return
  end

  def not_found_exception
    render json: { message: I18n.t('company.errors.not_found'), status: :not_found }  and return
  end
end
