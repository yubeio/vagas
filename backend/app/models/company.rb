# frozen_string_literal: true

class Company < ApplicationRecord
  before_save :cnpj_stripped

  validates_presence_of :name, :cnpj, :employees_number, :processes_number
  validates_uniqueness_of :cnpj
  validate :cnpj_valid?

  default_scope -> { Company.active }
  scope :all_with_deleted, -> { unscoped }

  enum status: %i[active deleted]

  private

  def cnpj_stripped
    self.cnpj = CNPJ.new(cnpj).stripped
  end

  def cnpj_valid?
    binding.pry
    if CNPJ.valid?(cnpj, strict: true)
      self.cnpj = CNPJ.new(cnpj).stripped
    else
      errors.add(:base, I18n.t('company.errors.attributes.cnpj.invalid'))
    end
  end
end
