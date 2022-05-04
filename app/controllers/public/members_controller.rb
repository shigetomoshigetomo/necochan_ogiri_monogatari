class Public::MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to action: :show
    else
      @member = current_member
      render "public/members/edit"
    end
  end

  def index
    @members = Member.all
  end

  private

    def member_params
      params.require(:member).permit(:name, :email)
    end
end
