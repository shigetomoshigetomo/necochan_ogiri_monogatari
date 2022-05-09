class Admin::PostsController < ApplicationController

  def show
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
  end

end
