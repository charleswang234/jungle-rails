class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    @review.user = current_user
    @review.save!
    redirect_to product_path(@product), notice: 'Review Created'

    # raise "Yay, I'm here!"

  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating,
      )
  end
end
