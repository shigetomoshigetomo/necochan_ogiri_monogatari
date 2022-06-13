class Public::BoardsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:new, :create]

  impressionist :actions => [:show]

  def index
    @tags = ActsAsTaggableOn::Tag.all
    if params[:sort] == "popular"
      boards = Board.posts_rank
      @boards = Kaminari.paginate_array(boards).page(params[:page]).per(6)
    elsif params[:sort] == "browsing"
      boards = Board.views_rank
      @boards = Kaminari.paginate_array(boards).page(params[:page]).per(6)
    else
      @boards = Board.all.page(params[:page]).per(6)
    end
  end

  def tag_index
    @tags = ActsAsTaggableOn::Tag.all
    if params[:tag]
      @tag = params[:tag]
      @boards = Board.tagged_with(@tag).page(params[:page]).per(6)
    end
  end

  def show
    @board = Board.find(params[:id])
    if params[:sort] == "popular"
      board_posts = @board.posts.favorites_rank
      @board_posts = Kaminari.paginate_array(board_posts).page(params[:page]).per(6)
    else
      @board_posts = @board.posts.page(params[:page]).per(6)
    end
    @post = Post.new
    impressionist(@board, nil, unique: [:session_hash.to_s])
    @tags = ActsAsTaggableOn::Tag.all
  end

  def new
    @board = Board.new
    @tags = ActsAsTaggableOn::Tag.all
  end

  def create
    @board = Board.new(board_params)
    @board.member_id = current_member.id
    member = current_member
    if @board.save
      exp = @board.board_get_exp
      money = @board.board_get_money
      member.add_money(money)
      member.update(:exp => member.exp + exp)
      #memberの新しい経験値以下の闘値から、一番近いものを探し出す
      level = Level.where("threshold <= ?", member.exp).order(level: :desc).first
      if level != member.level
        member.update(:level => level.level)
      end
      if member.saved_change_to_level?　　#memberのlebelカラムが更新されているか？
        flash[:alert] = "お題を投稿し、経験値#{exp}と#{money}マネーを獲得！レベルが#{member.level}になった！"
      else
        flash[:notice] = "お題を投稿し、経験値#{exp}と#{money}マネーを獲得！"
      end
      redirect_to board_path(@board)
    else
      @tags = ActsAsTaggableOn::Tag.all
      render "public/boards/new"
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :image, :tag_list)
  end
end
