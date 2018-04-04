module RenderHelper
  def success_render(locale)
    render json: { message: I18n.t(locale), status: :ok } and return
  end

  def failure_render(locale, object)
    render json: { message: I18n.t(locale),
                   details: object.errors.full_messages || '',
                   status: :bad_request } and return
  end
end
