class Public::UnlikesController < ApplicationController
  before_action :authenticate_member!

  def create
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    unlike = current_member.unlikes.new(post_id: @post.id)
    unlike.save
    redirect_to request.referer
  end

  def destroy
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    unlike = current_member.unlikes.find_by(post_id: @post.id)
    unlike.destroy
    redirect_to request.referer
  end
end
