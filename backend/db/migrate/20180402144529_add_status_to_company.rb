# frozen_string_literal: true

class AddStatusToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :status, :integer, default: 0
  end
end
