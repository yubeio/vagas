class YubeClient < ApplicationRecord
  include Mixins::Tombstoneable

  validates :document_cnpj, :social_name, :employees_quantity, presence: true
  validates :document_cnpj, length: { is: 14 }

  has_many :approval_processes

  def count_processes
    ApprovalProcess.where(yube_client_id: self.id).count
  end
end
