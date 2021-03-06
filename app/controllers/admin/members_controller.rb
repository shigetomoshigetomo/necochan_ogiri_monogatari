class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.not_guest.order(created_at: "ASC").page(params[:page])
    if params[:is_deleted]
      @members = Member.not_guest.where(is_deleted: params[:is_deleted]).page(params[:page])
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_member_path(@member), notice: "#{@member.name}さんの会員ステータスを更新しました"
    else
      render "edit"
    end
  end

  private

  def member_params
    params.require(:member).permit(:is_deleted)
  end
end
