class ProductsController < ApplicationController
  def index
    @products = Product.order(crated_at: :desc).limit(9)
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.category
  end
end
