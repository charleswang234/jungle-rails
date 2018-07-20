class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc).includes(:reviews)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.includes(:user)
    @logged_in = logged_in?
    @current_user = current_user
    if @reviews.size > 0
      @rating_avg = @reviews.average(:rating).round(2)
    else
      @rating_avg = "no ratings"
    end
  end

end
