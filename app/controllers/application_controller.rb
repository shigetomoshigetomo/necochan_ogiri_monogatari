class ApplicationController < ActionController::Base

  def ensure_guest_member
    if current_member.name == "ゲスト"
      redirect_to request.referer
    end
  end

end
