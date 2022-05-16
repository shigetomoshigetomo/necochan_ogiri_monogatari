module Public::MembersHelper

  def notification_form(notification)
    @visitor = notification.visitor
    your_post = link_to 'あなたの投稿', board_post_path(notification), style:"font-weight: bold;"
    case notification.action
      when "follow" then
        tag.a(notification.visitor.name, href:member_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visitor.name, href:member_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:board_post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
    end
  end

  def unchecked_notifications
    @notifications = current_member.passive_notifications.where(checked: false)
  end
end
