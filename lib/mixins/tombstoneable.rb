module Mixins::Tombstoneable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted: false) }
    scope :include_deleted, -> { unscope(where: :deleted) }
    scope :deleted, -> { include_deleted.where(deleted: true) }
  end

  def destroy
    update_attribute(:deleted, true)
  end

  def delete
    destroy
  end

  def undelete
    assign_attributes(deleted: false)
  end

  def undelete!
    update_attribute(:deleted, false)
  end
end
