class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @members = Member.where("name LIKE?","%#{@word}%")
    @boards = Board.where("title LIKE?","%#{@word}%")
    @posts = Post.where("content LIKE?","%#{@word}%")
  end

end
