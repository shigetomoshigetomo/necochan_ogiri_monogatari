class Admin::BoardsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @board = Board.find(params[:id])
  end

end
