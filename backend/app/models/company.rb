class Company < ApplicationRecord
  enum status: [:active, :deleted]

  validates_presence_of :name, :cnpj, :employees_number, :processes_number
  validate :cnpj_valid
  default_scope -> { Company.active }
  scope :all_with_deleted, -> { unscoped.all }

  def self.json_all
    Company.all.to_json
  end

  def cnpj_valid
    unless CNPJ.new(cnpj).valid?
      errors.add(:base, 'company.attributes.cnpj.invalid')
    end
  end
end
