class Public::UnlikesController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member

  def create
    @post = Post.find(params[:post_id])
    unlike = current_member.unlikes.new(post_id: @post.id)
    unlike.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    unlike = current_member.unlikes.find_by(post_id: @post.id)
    unlike.destroy
  end
end
