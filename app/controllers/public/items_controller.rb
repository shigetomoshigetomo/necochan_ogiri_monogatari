class Public::ItemsController < ApplicationController
  before_action :authenticate_member!

  def index
    @genres = Genre.all
    if params[:shop]
      @genre = Genre.find(params[:shop])
      @items = @genre.items
    else
      @items = Item.where(genre_id: 1)
    end
  end

  def show
    @item = Item.find(params[:id])
    @order = Order.new
  end
end
