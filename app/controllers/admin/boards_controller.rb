class Admin::BoardsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @board = Board.find(params[:id])
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to admin_search_path, notice: "お題を削除しました。"
  end
end
