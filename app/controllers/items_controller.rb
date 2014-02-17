class ItemsController < ApplicationController
  before_action :verify_logged_in

  def index
    @items = Item.all.sort_by(&:created_at).reverse
    @newitem = Item.new
    
  end

  def create
    @item = Item.new(params.require(:item).permit(:item_name, :item_price))
    if @item.save
      redirect_to items_path
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params.require(:item).permit(:item_name, :item_price))
      redirect_to @item
    else
      flash[:error] = "List not udpated"
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to items_path
  end

  private

  def verify_logged_in
    if !current_user
      flash[:error] = "Login require"
      redirect_to new_auth_path
    end
  end

end
