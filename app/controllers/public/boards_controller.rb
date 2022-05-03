class Public::BoardsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @post = Post.new
  end

  def new
    @board = Board.new
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
      render "new"
    end
  end

  private

    def board_params
      params.require(:board).permit(:title, :image)
    end
end
