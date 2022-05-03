class Public::OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    @order.member_id = current_member.id
    @remainder = current_member.money - @order.item.price
    @exp = current_member.exp + @order.item.having_exp
    if @remainder >= 0
      @order.save
      @member.update_attribute(:money, @remainder)
      @member.update_attribute(:exp, @exp)
      redirect_to items_path
    else
      flash[:notice] = "マネーが足りません。"
      redirect_to request.referer
    end
  end

  private

    def order_params
      params.require(:order).permit(:item_id, :member_id)
    end
end
