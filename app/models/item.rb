class Item < ApplicationRecord

  default_scope { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  def soft_delete
    self.update(deleted_at: DateTime.now)
  end

  def restore
    self.update(deleted_at: nil)
  end
end
