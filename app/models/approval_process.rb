class ApprovalProcess < ApplicationRecord
  has_enumeration_for :status, with: ApprovalProcesses::Status,
    create_helpers: true,
    create_scopes: true
end
