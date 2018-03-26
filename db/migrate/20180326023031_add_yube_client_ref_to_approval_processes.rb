class AddYubeClientRefToApprovalProcesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :approval_processes, :yube_client, foreign_key: true
  end
end
