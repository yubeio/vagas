class Proccess < ApplicationRecord
  belongs_to :client

  validates :name, :description, presence: true
  enum status: [ :rejected, :pending, :aproved ]
  
end
