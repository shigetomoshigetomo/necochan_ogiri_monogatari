class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    @word = params[:word]
    @members = Member.where("name LIKE?","%#{@word}%").page(params[:page]).per(10)
    @boards = Board.where("title LIKE?","%#{@word}%").page(params[:page]).per(6)
    @posts = Post.where("content LIKE?","%#{@word}%").page(params[:page]).per(6)
  end

end
