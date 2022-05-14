class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      flash.now[:notice] = "ジャンルを登録しました。"
    else
      @genres = Genre.all
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンル情報を更新しました"
      redirect_to admin_genres_path
    else
      render "edit"
    end
  end

  private

    def genre_params
      params.require(:genre).permit(:name)
    end
end
