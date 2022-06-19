class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    if @word.blank?
      redirect_to request.referer
      flash[:notice] = "キーワードを入力して下さい。"
    else
      @members = Member.not_guest.where("name LIKE?", "%#{@word}%").order(created_at: "ASC")
      @boards = Board.where("title LIKE?", "%#{@word}%")
      @posts = Post.where("content LIKE?", "%#{@word}%")
    end
  end
end
