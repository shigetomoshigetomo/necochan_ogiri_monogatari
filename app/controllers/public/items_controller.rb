class Public::ItemsController < ApplicationController
  
  
  def index
    @genres = Genre.all
    if params[:shop]
      @genre = Genre.find(params[:shop])
      @items = @genre.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @order = Order.new
  end
end
