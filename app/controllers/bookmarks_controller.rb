class BookmarksController < ApplicationController

  # def index
  #   @bookmarks = Bookmark.where(list_id: params[:list_id])
  # end

  # def new
  #   @bookmark = Bookmark.new
  #   @list = List.find(params[:list_id])
  # end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    @bookmark.save!
    redirect_to list_path(@list)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list_id)
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

end
