class PagesController < ApplicationController

  def index
    @pages = Page.order(created_at: :desc)
  end

  def show
    @page = Page.find(params[:id])
  end
end
