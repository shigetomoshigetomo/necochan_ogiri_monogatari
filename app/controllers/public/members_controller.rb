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
    if params[:sort] == "favorites"
      @all_members = Member.where.not(email: 'guest@example.com')
      @members = @all_members.sort { |a,b|
                                    b.posts.inject(0) { |sum, post| sum + post.favorites.count } <=>
                                    a.posts.inject(0) { |sum, post| sum + post.favorites.count }
                                    }
    else
      @members = Member.where.not(email: 'guest@example.com').order(params[:sort])
    end
  end

  private

    def member_params
      params.require(:member).permit(:name, :email, :profile_image)
    end
end
