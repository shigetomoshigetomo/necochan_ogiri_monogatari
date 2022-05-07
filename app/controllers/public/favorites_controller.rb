class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
    redirect_to request.referer
  end
end
