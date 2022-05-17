class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @members = Member.not_guest.where("name LIKE?","%#{@word}%").page(params[:page]).per(10)
    @boards = Board.where("title LIKE?","%#{@word}%").page(params[:page]).per(6)
    @posts = Post.where("content LIKE?","%#{@word}%").page(params[:page]).per(6)
  end

end
