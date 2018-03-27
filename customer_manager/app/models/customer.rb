class Customer < ApplicationRecord
  validates_presence_of :cnpj, :corporate_name
  validates :employees, numericality: { only_integer: true, greater_than: 1 }

  has_many :procedures, dependent: :destroy

  scope :active, -> { where(deleted: false) }
end
