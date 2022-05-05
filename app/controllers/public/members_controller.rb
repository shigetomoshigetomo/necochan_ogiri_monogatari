class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
    near_level = Level.find_by(level: @member.level + 1)
    @gap_exp = near_level.threshold - @member.exp
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to action: :show
    else
      @member = Member.find(params[:id])
      render "public/members/edit"
    end
  end

  def index
    @members = Member.all
  end

  private

    def member_params
      params.require(:member).permit(:name, :email, :profile_image)
    end
end
