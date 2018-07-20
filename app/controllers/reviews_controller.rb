class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    @review.user = current_user
    @review.save!
    redirect_to product_path(@product), notice: 'Review Created'

    # raise "Yay, I'm here!"
  end


  def destroy
    @review = Review.find(params[:id])

    @product = @review.product
    if (@review.user == current_user)
      @review.destroy
    end
    redirect_to product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating,
      )
  end

  def require_login
    if !logged_in?
      flash[:notice] = "Please login to continue"
      redirect_to root_path
    end
  end


end
