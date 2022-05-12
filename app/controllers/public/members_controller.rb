class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :update]

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
      redirect_to "show"
    else
      @member = Member.find(params[:id])
      render "edit"
    end
  end

  def index
    @all_members = Member.where.not(email: 'guest@example.com')
    if params[:sort] == "favorites"
      @members = @all_members.sort { |a,b|
                                    b.posts.inject(0) { |sum, post| sum + post.favorites.count } <=>
                                    a.posts.inject(0) { |sum, post| sum + post.favorites.count }
                                    }
    elsif params[:sort] == "followers"
      @members = @all_members.all.sort { |a,b| b.followers.count <=> a.followers.count }
    else
      @members = Member.where.not(email: 'guest@example.com').order(params[:sort])
    end
  end

  def my_favorites
    @member = Member.find(params[:member_id])
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorites_post = Post.find(favorites)
  end

  private

    def member_params
      params.require(:member).permit(:name, :email, :profile_image)
    end
end
