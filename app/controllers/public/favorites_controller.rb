class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member

  def create
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
    #いいねの通知を作成
    @post.create_notification_like!(current_member)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end
