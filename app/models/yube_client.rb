class YubeClient < ApplicationRecord
  has_many :approval_processes

  def count_processes
    ApprovalProcess.where(yube_client_id: self.id).count
  end
end
