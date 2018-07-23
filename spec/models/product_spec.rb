require 'rails_helper'

RSpec.describe Product, type: :model do



 describe 'Validations' do
  before :each do
    @category = Category.create(name: "cool")
    @product = Product.new(name: "charles", price: 20, quantity: 4, category: @category)
  end


  it "is valid with all properties" do
    expect(@product).to be_valid

  end

  it "is not valid without a name" do
    @product.name = nil
    @product.save
    # puts @product.errors.full_messages
    # binding.pry
    expect(@product).not_to be_valid
    expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
  end

  it "is not valid without a price" do
    @product.price_cents = nil
    @product.save
    expect(@product).not_to be_valid
    expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
    expect(@product.errors.full_messages[1]).to eq("Price is not a number")
    expect(@product.errors.full_messages[2]).to eq("Price can't be blank")
  end

  it "is not valid without a quantity" do
    @product.quantity = nil
    @product.save
    expect(@product).not_to be_valid
    expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
  end

  it "is not valid without a category" do
    @product.category = nil
    @product.save
    expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
    expect(@product).not_to be_valid
  end


end

end
