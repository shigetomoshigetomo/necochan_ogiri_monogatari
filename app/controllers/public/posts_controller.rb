class Public::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:create]

  def show
    @tags = ActsAsTaggableOn::Tag.all
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
  end

  def index
    @tags = ActsAsTaggableOn::Tag.all
    if params[:sort] == "popular"
      posts = Post.favorites_rank
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(6)
    else
      @posts = Post.all.page(params[:page]).per(6)
    end
  end

  def create
    @board = Board.find(params[:board_id])
    @post = current_member.posts.new(post_params)
    @post.board_id = @board.id
    member = current_member
    if @post.save
      exp = @post.get_exp
      money = @post.get_money
      member.add_money(money)
      member.update(:exp => member.exp + exp)
      level = Level.where("threshold <= #{member.exp}").order(level: :desc).first
      if level != member.level
        member.update(:level => level.level)
      end
      if member.saved_change_to_level?
        flash[:alert] = "答えを投稿し、経験値#{exp}と#{money}マネーを獲得！レベルが#{member.level}になった！"
      else
        flash[:notice] = "答えを投稿し、経験値#{exp}と#{money}マネーを獲得！"
      end
      redirect_to board_path(@board)
    else
      @tags = ActsAsTaggableOn::Tag.all
      @board_posts = @board.posts.page(params[:page]).per(6)
      render "public/boards/show"
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
