class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
  end

  def destroy
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_reports_path, notice: "答えを削除しました。"
  end
end
