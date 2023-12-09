class ItemsController < ApplicationController
  before_action :_get_item, only: [:destroy, :restore]

  def index
    @active_items = Item.all
    @deleted_items = Item.unscoped.deleted
  end

  def new
  end

  def create
    Item.create!(_item_params)
    redirect_to root_path, notice: "Item created successfully"
  end

  def destroy
    @item.soft_delete
    redirect_to root_path, notice: "Item soft-deleted successfully"
  end

  def restore
    @item.restore
    redirect_to root_path, notice: "Item restored successfully"
  end

  private
  def _get_item
    @item = Item.unscoped.find_by(id: params[:id])
  end

  def _item_params
    params.require(:item).permit(:name)
  end
end
