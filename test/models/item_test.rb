require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "should mark item as soft-deleted" do
    item = items(:one)
    item.soft_delete
    assert_not_nil item.reload.deleted_at
  end

  test "should restore soft-deleted item" do
    soft_deleted_item = items(:soft_deleted)
    soft_deleted_item.restore
    assert_nil soft_deleted_item.reload.deleted_at
  end

  test "default scope should exclude soft-deleted items" do
    active_item = items(:one)
    soft_deleted_item = items(:soft_deleted)
    assert_includes Item.all, active_item
    assert_not_includes Item.all, soft_deleted_item
  end
end
