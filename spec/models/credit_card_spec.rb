RSpec.describe CreditCard do
  it "has a valid factory" do
    expect(build_stubbed(:credit_card)).to be_valid
  end

  it "validates the presence of name" do
    expect(build_stubbed(:credit_card, name: nil)).not_to be_valid
  end

  it "validates the presence of number" do
    expect(build_stubbed(:credit_card, number: nil)).not_to be_valid
  end

  it "validates the format of number" do
    expect(build_stubbed(:credit_card, number: "4242424242424241")).not_to be_valid
  end

  it "validates the presence of exp_month" do
    expect(build_stubbed(:credit_card, exp_month: nil)).not_to be_valid
  end

  it "validates the format of exp_month" do
    aggregate_failures do
      expect(build_stubbed(:credit_card, exp_month: "invalid")).not_to be_valid
      expect(build_stubbed(:credit_card, exp_month: "00")).not_to be_valid
      expect(build_stubbed(:credit_card, exp_month: "010")).not_to be_valid
      expect(build_stubbed(:credit_card, exp_month: "13")).not_to be_valid
    end
  end

  it "validates the presence of exp_year" do
    expect(build_stubbed(:credit_card, exp_year: nil)).not_to be_valid
  end

  it "validates the format of exp_year" do
    aggregate_failures do
      expect(build_stubbed(:credit_card, exp_year: "5")).not_to be_valid
      expect(build_stubbed(:credit_card, exp_year: "invalid")).not_to be_valid
    end
  end

  it "validates the card has not expired" do
    travel_to(Time.zone.today.change(month: 6)) do
      aggregate_failures do
        expect(build_stubbed(:credit_card, exp_month: Time.zone.today.month - 1, exp_year: Time.zone.today.year)).not_to be_valid
        expect(build_stubbed(:credit_card, exp_month: Time.zone.today.month + 1, exp_year: Time.zone.today.year - 1)).not_to be_valid
        expect(build_stubbed(:credit_card, exp_month: Time.zone.today.month - 1, exp_year: Time.zone.today.year + 1)).to be_valid
        expect(build_stubbed(:credit_card, exp_month: Time.zone.today.month, exp_year: Time.zone.today.year)).to be_valid
      end
    end
  end

  it "validates the presence of cvc" do
    expect(build_stubbed(:credit_card, cvc: nil)).not_to be_valid
  end

  it "validates the format of cvc" do
    expect(build_stubbed(:credit_card, cvc: "12345678790")).not_to be_valid
  end
end
