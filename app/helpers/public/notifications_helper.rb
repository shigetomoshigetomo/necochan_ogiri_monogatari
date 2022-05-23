module Public::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    case notification.action
    when "follow" then
      tag.a(notification.visitor.name, href: member_path(@visitor), class: "tag") + "さんがあなたをフォローしました"
    when "like" then
      tag.a(notification.visitor.name, href: member_path(@visitor), class: "tag") + "さんが" + tag.a('あなたの答え', href: board_post_path(notification.post.board_id, notification.post_id), class: "tag") + "に肉球スタンプを押しました"
    end
  end

  def unchecked_notifications
    @notifications = current_member.passive_notifications.where(checked: false)
  end
end
