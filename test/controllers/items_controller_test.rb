require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get items_url
    assert_response :success
    assert_template :index
  end

  test "should exclude soft-deleted items from index" do
    soft_deleted_item = items(:soft_deleted)
    get items_url
    assert_not assigns(:active_items).include?(@item)
    assert assigns(:deleted_items).include?(soft_deleted_item)
  end

  test "should get new" do
    get new_item_url
    assert_response :success
    assert_template :new
  end

  test "should create item" do
    assert_difference('Item.count', 1) do
      post items_url, params: { item: { name: 'New Item' } }
    end
    assert_redirected_to root_url
    assert_equal "Item created successfully", flash[:notice]
  end

  test "should destroy item" do
    delete item_url(@item)
    assert_not_nil @item.reload.deleted_at
    assert_redirected_to root_url
    assert_equal "Item soft-deleted successfully", flash[:notice]
  end

  test "should restore item" do
    soft_deleted_item = items(:soft_deleted)
    patch restore_item_url(soft_deleted_item)
    assert_nil soft_deleted_item.reload.deleted_at
    assert_redirected_to root_url
    assert_equal "Item restored successfully", flash[:notice]
  end
end
