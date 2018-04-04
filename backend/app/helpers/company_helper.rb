module CompanyHelper

  def exception_params(e)
    super.render json: { message: "#{e.message}", status: :bad_request } and return
  end
end
