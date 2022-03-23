class CreditCard < ApplicationRecord
  validates :name, presence: true
  validates :number, presence: true, credit_card_number: true
  validates :exp_month, presence: true, format: {with: /\A((0?[1-9])|(1[0-2]))\z/}
  validates :exp_year, presence: true, format: {with: /\A([0-9]{4})\z/}
  validates :cvc, presence: true, format: {with: /\A([0-9]{3,4})\z/}

  validate :validate_expiration

  private

  def validate_expiration
    return if exp_month.blank?
    return if exp_year.blank?

    if exp_year.to_i < Time.zone.today.year || exp_year.to_i == Time.zone.today.year && exp_month.to_i < Time.zone.today.month
      errors.add :base, "This card has expired."
    end
  end
end
