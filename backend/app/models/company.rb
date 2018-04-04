# frozen_string_literal: true

class Company < ApplicationRecord
  before_save :cnpj_stripped

  validates_presence_of :name, :cnpj, :employees_quantity
  validates_uniqueness_of :cnpj
  validate :cnpj_valid?

  has_many :company_processes

  default_scope -> { Company.active }
  scope :all_with_deleted, -> { unscoped }

  enum status: %i[active deleted]

  def processes_quantity
    @processes_quantity ||= company_processes.count
  end

  private

  def cnpj_stripped
    self.cnpj = CNPJ.new(cnpj).stripped
  end

  def cnpj_valid?
    if CNPJ.valid?(cnpj, strict: true)
      self.cnpj = CNPJ.new(cnpj).stripped
    else
      errors.add(:base, I18n.t('company.errors.attributes.cnpj.invalid'))
    end
  end
end
