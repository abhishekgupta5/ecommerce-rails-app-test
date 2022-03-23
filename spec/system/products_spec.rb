RSpec.describe "Products" do
  it "can be seen on the home page" do
    product = create(:product)

    visit root_path

    expect(page).to have_content(product.name)
  end

  it "can be added to the cart" do
    create(:product)

    visit root_path
    click_button "Add to bag"

    expect(page).to have_content("1")
  end
end
