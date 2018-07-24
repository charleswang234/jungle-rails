require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
  end

  scenario "They can click and navigate to the products page" do

    visit root_path

    # save_screenshot

    page.find('article').find('header').click
    expect(page).to have_content("Reviews")
    save_screenshot
  end

  scenario "They can click on details and navigate to the products page" do

    visit root_path

    page.find('footer').find('.pull-right').click
    expect(page).to have_content("Reviews")
    save_screenshot
  end

end
