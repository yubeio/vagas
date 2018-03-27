class Procedure < ApplicationRecord
  validates_presence_of :name

  belongs_to :customer

  scope :active, -> { where(deleted: false) }

  after_create :add_customers_procedures_count
  after_update :sub_customers_procedures_count, if: :saved_change_to_deleted?

  STATUS = {
    pending: 'Pending',
    approved: 'Approved',
    refused: 'Refused'
  }

  # Must receive ActiveRecord
  def self.disable_procedures(procedures)
    procedures.update_all(deleted: true)
  end

  private

  def add_customers_procedures_count
    unless self.deleted == true
      customer = Customer.find(self.customer.id)
      customer.procedures_count += 1
      customer.save!
    end
  end

  def sub_customers_procedures_count
    if self.deleted == true
      customer = Customer.find(self.customer.id)
      customer.procedures_count -= 1
      customer.save!
    else
      add_customers_procedures_count
    end
  end
end
