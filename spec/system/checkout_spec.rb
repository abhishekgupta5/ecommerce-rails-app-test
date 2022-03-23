RSpec.describe "Checkout" do
  it "can be completed" do
    create(:product)
    order = attributes_for(:order)
    shipping_address = attributes_for(:address)
    credit_card = attributes_for(:credit_card)

    visit root_path
    click_button "Add to bag"
    fill_in "Email address", with: order[:email]
    fill_in "First name", with: shipping_address[:first_name]
    fill_in "Last name", with: shipping_address[:last_name]
    fill_in "Address", with: shipping_address[:line1]
    fill_in "ZIP", with: shipping_address[:zip]
    fill_in "City", with: shipping_address[:city]
    fill_in "State", with: shipping_address[:state]
    select ISO3166::Country.find_country_by_alpha2(shipping_address[:country]).name, from: "Country"
    fill_in "Card number", with: credit_card[:number]
    fill_in "Name on card", with: credit_card[:name]
    fill_in "Expiration month", with: credit_card[:exp_month]
    fill_in "Expiration year", with: credit_card[:exp_year]
    fill_in "CVC", with: credit_card[:cvc]
    click_button "Confirm order"

    expect(page).to have_content("THANK YOU!")
  end
end
