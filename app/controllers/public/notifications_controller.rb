class Public::NotificationsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_current_member

  def index
    @member = Member.find(params[:member_id])

    #自分の投稿に対する通知を除く通知を取得する
    @notifications = @member.passive_notifications.where.not(visitor_id: @member.id).page(params[:page])
    #未確認の通知を確認済へ変更していく
    @notifications.where(checked: false).each do |notification|
      notification.update(:checked => true)
    end
  end

  def ensure_current_member
    if current_member.id != params[:member_id].to_i
      flash[:notice] = "権限がありません"
      redirect_to boards_path
    end
  end
end
