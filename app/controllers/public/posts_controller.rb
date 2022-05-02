class Public::PostsController < ApplicationController

  def show

  end

  def index
  end

  def create
    @board = Board.find(params[:board_id])
    @post = current_member.posts.new(post_params)
    @post.board_id = @board.id
    if @post.save
      redirect_to request.referer
    else
      render "board/show"
    end
  end

  private

    def post_params
      params.require(:post).permit(:content, :image)
    end
end
