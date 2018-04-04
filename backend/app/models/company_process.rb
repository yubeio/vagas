class CompanyProcess < ApplicationRecord
  belongs_to :company

  validates_presence_of %i[name description]

  enum status: %i[pending accepted rejected]

  def update_status(params)
    status = params[:status]

    if status_valid?(status)
      status << '!' and send(status)
    else
      errors.add(:base, I18n.t('company_process.failure.status_updated'))
    end
  end

  private

  def status_valid?(status)
    self.class.statuses.include? status
  end
end
