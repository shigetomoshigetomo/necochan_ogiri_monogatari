class Public::BoardsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.member_id = current_member.id
    if @board.save
      redirect_to board_path(@board), notice: "お題を投稿しました"
    else
      render "new"
    end
  end

  private

    def board_params
      params.require(:board).permit(:title, :member_id, :image)
    end
end
