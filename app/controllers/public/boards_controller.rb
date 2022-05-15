class Public::BoardsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:new, :create]

  impressionist :actions=> [:show]

  def index
    @tags = ActsAsTaggableOn::Tag.all
    if params[:sort] == "popular"
      boards = Board.posts_rank
      @boards = Kaminari.paginate_array(boards).page(params[:page]).per(6)
    elsif params[:sort] == "browsing"
      boards = Board.views_rank
      @boards = Kaminari.paginate_array(boards).page(params[:page]).per(6)
    else
      boards = Board.all.order(params[:sort])
      @boards = Kaminari.paginate_array(boards).page(params[:page]).per(6)
    end
  end

  def tag_index
    @tags = ActsAsTaggableOn::Tag.all
    if params[:tag]
      @boards = Board.tagged_with(params[:tag])
    end
  end

  def show
    @board = Board.find(params[:id])
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
    if @board.save
      member = current_member
      #ランダムに経験値とマネーが加算される
      get_exp = rand(1..2)
      get_money = rand(1..3)
      total_exp = get_exp + member.exp
      total_money = get_money + member.money
      member.update_attribute(:exp, total_exp)
      member.update_attribute(:money, total_money)
      #一つ上のレベルを探し、比較していく
      near_level = Level.find_by(level: member.level + 1)
      while near_level.threshold <= member.exp
        member.update_attribute(:level, member.level + 1)
        near_level = Level.find_by(level: member.level + 1)
      end

      if member.saved_change_to_level?
        flash[:notice] = "お題を投稿し、経験値#{get_exp}と#{get_money}マネーを獲得！レベルが#{member.level}になった！"
      else
        flash[:notice] = "お題を投稿し、経験値#{get_exp}と#{get_money}マネーを獲得！"
      end
      redirect_to board_path(@board)
    else
      @tags = ActsAsTaggableOn::Tag.all
      render "new"
    end
  end

  private

    def board_params
      params.require(:board).permit(:title, :image, :tag_list)
    end

end
