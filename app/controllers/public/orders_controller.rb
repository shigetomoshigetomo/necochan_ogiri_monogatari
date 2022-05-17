class Public::OrdersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:create]

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new(order_params)
    @order.member_id = current_member.id
    remainder = current_member.money.to_i - @order.item.price.to_i
    new_exp = current_member.exp + @order.item.having_exp
    if remainder >= 0
      @order.save
      member = current_member
      member.update_attribute(:money, remainder)
      member.update_attribute(:exp, new_exp)
      #一つ上のレベルを探し、比較していく
      near_level = Level.find_by(level: member.level + 1)
      while near_level.threshold <= member.exp
        member.update_attribute(:level, member.level + 1)
        near_level = Level.find_by(level: member.level + 1)
      end

      if member.saved_change_to_level?
        flash[:notice] = "#{@item.name}を手に入れ、経験値#{@item.having_exp}を獲得！レベルが#{member.level}になった！"
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
      params.require(:order).permit(:item_id, :member_id)
    end
end
