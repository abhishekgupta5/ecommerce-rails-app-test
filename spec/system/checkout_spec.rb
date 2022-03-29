RSpec.describe "Checkout" do
  it "can be completed for a valid country" do
    create(:product)
    order = attributes_for(:order)
    shipping_address = attributes_for(:address)
    credit_card = attributes_for(:credit_card)
    shipping_method = create(:shipping_method, country: shipping_address[:country])
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
    # expect delivery info on checkout form page when correct country is selected
    expect_delivery_info_on_page(shipping_method)
    fill_in "Card number", with: credit_card[:number]
    fill_in "Name on card", with: credit_card[:name]
    fill_in "Expiration month", with: credit_card[:exp_month]
    fill_in "Expiration year", with: credit_card[:exp_year]
    fill_in "CVC", with: credit_card[:cvc]
    click_button "Confirm order"

    # expect delivery info on summary page
    expect(page).to have_content("THANK YOU!")
    expect_delivery_info_on_page(shipping_method)
  end

  it "shouldn't allow submission for country where delivery isn't supported" do
    create(:product)
    visit root_path
    click_button "Add to bag"
    ShippingMethod.where(country: "IN").delete_all
    select ISO3166::Country.find_country_by_alpha2("IN").name, from: "Country"
    # expect delivery info on checkout form page when invalid country is selected
    ensure_delivery_not_possible
  end

  it "ensure the working of selected country dropdown" do
    create(:product)
    shipping_method = create(:shipping_method, country: "IT")
    shipping_method2 = create(:shipping_method, country: "DE")
    visit root_path
    click_button "Add to bag"

    # Select a valid country
    select ISO3166::Country.find_country_by_alpha2(shipping_method.country).name, from: "Country"
    expect_delivery_info_on_page(shipping_method)

    # Select an invalid country
    ShippingMethod.where(country: "US").delete_all
    select ISO3166::Country.find_country_by_alpha2("US").name, from: "Country"
    ensure_delivery_not_possible

    # Select another valid country
    select ISO3166::Country.find_country_by_alpha2(shipping_method2.country).name, from: "Country"
    expect_delivery_info_on_page(shipping_method2)
  end

  def expect_delivery_info_on_page(shipping_method)
    # Expect delivery method to be shown
    expect(page).to have_content(shipping_method.name)
    # Expect delivery time to be shown
    expect(page).to have_content("within #{shipping_method.delivery_time_in_days} days")
  end

  def ensure_delivery_not_possible
    # Expect the page to show the non-deliverable message
    expect(page).to have_content("we don't deliver in your country yet")
    # Expect the page to not show Confirm order button
    expect(page).to have_no_content("Confirm order")
  end
end
