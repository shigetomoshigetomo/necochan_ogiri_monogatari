class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :update]
  before_action :ensure_current_member, only: [:edit, :update]

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
      redirect_to "show", notice: "会員情報を更新しました"
    else
      @member = Member.find(params[:id])
      render "edit"
    end
  end

  def index
    if params[:sort] == "favorites"
      members = Member.not_guest.all_favorites
      @members = Kaminari.paginate_array(members).page(params[:page]).per(10)
    elsif params[:sort] == "followers"
      members = Member.not_guest.follower_rank
      @members = Kaminari.paginate_array(members).page(params[:page]).per(10)
    else
      @members = Member.not_guest.order(params[:sort]).page(params[:page]).per(10)
    end
  end

  def my_favorites
    @member = Member.find(params[:member_id])
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    favorites_post = Post.find(favorites)
    @favorites_post = Kaminari.paginate_array(favorites_post).page(params[:page]).per(6)
  end

  def friends
    @member = Member.find(params[:member_id])
    @follower_members = @member.followers.page(params[:page]).per(10)
    @following_members = @member.followings.page(params[:page]).per(10)
  end

  def member_boards
    @member = Member.find(params[:member_id])
    if params[:sort] == "popular"
      boards = @member.boards.posts_rank
      @boards = Kaminari.paginate_array(boards).page(params[:page]).per(6)
    else
      @boards = @member.boards.all.order(params[:sort]).page(params[:page]).per(6)
    end
  end

  def member_posts
    @member = Member.find(params[:member_id])
    if params[:sort] == "popular"
      posts = @member.posts.favorites_rank
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(6)
    else
      @posts = @member.posts.all.order(params[:sort]).page(params[:page]).per(6)
    end
  end

  def shoppings
    @orders = current_member.orders.page(params[:page]).per(10)
  end

  private

    def member_params
      params.require(:member).permit(:name, :email, :profile_image)
    end
end
