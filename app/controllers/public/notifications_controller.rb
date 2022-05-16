class Public::NotificationsController < ApplicationController
  before_action :authenticate_member!

  def index
    @member = Member.find(params[:member_id])

    @notifications = @member.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
end
