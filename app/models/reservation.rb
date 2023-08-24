# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :guest

  validates :code, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :adults, presence: true, numericality: { greater_than: 0 }
  validates :children, presence: true, numericality: { greater_than: -1 }
  validates :infants, presence: true, numericality: { greater_than: -1 }
  validates :status, presence: true
  validates :host_currency, presence: true
  validate :end_date_same_or_after_start_date

  private

  def end_date_same_or_after_start_date
    return unless end_date < start_date

    errors.add(:end_date, 'must be the same as or come after the start date')
  end
end
