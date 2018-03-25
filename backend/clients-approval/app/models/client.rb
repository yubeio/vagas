class Client < ApplicationRecord
  acts_as_paranoid
  has_many :client_process

  validates :cnpj, presence: true
  validates :cnpj, uniqueness: true
  validates :company_name, presence: true
  validates :officials_total, presence: true

end
