class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @members = Member.not_guest.where("name LIKE?", "%#{@word}%").order(created_at: "ASC")
    @boards = Board.where("title LIKE?", "%#{@word}%")
    @posts = Post.where("content LIKE?", "%#{@word}%")
  end
end
