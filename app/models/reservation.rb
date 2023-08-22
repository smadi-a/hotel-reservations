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
end
