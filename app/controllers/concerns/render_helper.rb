module RenderHelper
  def success_render(locale)
    render json: { message: I18n.t(locale), status: :ok } and return
  end

  def failure_render(locale, object)
    render json: { message: I18n.t(locale),
                   details: object.errors.full_messages || '',
                   status: :not_acceptable }, status: :not_acceptable and return
  end
end
