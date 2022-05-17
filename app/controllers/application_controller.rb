class ApplicationController < ActionController::Base

  def ensure_guest_member
    if current_member.name == "ゲスト"
      flash[:notice]="権限がありません"
      redirect_to request.referer
    end
  end

  def ensure_current_member
    if current_member.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to boards_path
    end
  end
end
