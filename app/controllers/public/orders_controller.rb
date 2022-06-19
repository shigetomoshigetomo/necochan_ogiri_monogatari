class Public::OrdersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:create]

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new(order_params)
    @order.member_id = current_member.id
    #残金
    remainder = current_member.money - @order.item.price
    if remainder >= 0
      @order.save
      member = current_member
      member.update(:money => remainder)
      member.update(:exp => member.exp + @order.item.having_exp)
      level = Level.where("threshold <= ?", member.exp).order(level: :desc).first
      if level != member.level
        member.update(:level => level.level)
      end
      if member.saved_change_to_level?
        flash[:alert] = "#{@item.name}を手に入れ、経験値#{@item.having_exp}を獲得！レベルが#{member.level}になった！"
      else
        flash[:notice] = "#{@item.name}を手に入れ、経験値#{@item.having_exp}を獲得！"
      end
      redirect_to items_path
    else
      redirect_to request.referer, notice: "マネーが足りません。"
    end
  end

  private

  def order_params
    params.require(:order).permit(:item_id, :member_id, :item_name, :item_price, :item_exp)
  end
end
