class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
  end

end
