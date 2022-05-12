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
      @posts = Post.favorites_rank
    else
      @posts = Post.all.order(params[:sort])
    end
  end

  def create
    @board = Board.find(params[:board_id])
    @post = current_member.posts.new(post_params)
    @post.board_id = @board.id
    if @post.save
      member = current_member
      #ランダムに経験値とマネーが加算される
      get_exp = rand(1..5)
      get_money = rand(3..6)
      total_exp = get_exp + member.exp
      total_money = get_money.to_i + member.money.to_i
      member.update_attribute(:exp, total_exp)
      member.update_attribute(:money, total_money)
      #一つ上のレベルを探し、比較していく
      near_level = Level.find_by(level: member.level + 1)
      while near_level.threshold <= member.exp
        member.update_attribute(:level, member.level + 1)
        near_level = Level.find_by(level: member.level + 1)
      end

      if member.saved_change_to_level?
        flash[:notice] = "答えを投稿し、経験値#{get_exp}と#{get_money}マネーを獲得！レベルが#{member.level}になった！"
      else
        flash[:notice] = "答えを投稿し、経験値#{get_exp}と#{get_money}マネーを獲得！"
      end
      redirect_to request.referer
    else
      @tags = ActsAsTaggableOn::Tag.all
      render "public/boards/show"
    end
  end

  private

    def post_params
      params.require(:post).permit(:content, :image)
    end
end
