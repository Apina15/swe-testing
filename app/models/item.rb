class Item < ApplicationRecord
    validates :name, :description, :total_stock, :avail_stock, :location, presence: {message: 'cannot be blank.'}
    validates :total_stock, :avail_stock, numericality: {only_integer: true, message: 'must be an integer.'}
    validates :total_stock, :avail_stock, numericality: {greater_than_or_equal_to: 0, message: 'must be nonnegative.'}
    validates :name, uniqueness: true, length: {maximum: 40, too_long: "is more than the maximum allowed (%{count} characters)."}
    validates :description, length: {maximum: 120, too_long: "is more than the maximum allowed (%{count} characters)."}
    validates :location, length: {maximum: 60, too_long: "is more than the maximum allowed (%{count} characters)."}
    validates :avail_stock, numericality: {less_than_or_equal_to: :total_stock, message: '(%{value}) must be less than total stock (%{count}).'}, unless: -> {total_stock.blank? || avail_stock.blank?}
    has_many :checkouts
end