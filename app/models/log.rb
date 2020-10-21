class Log < ApplicationRecord
  scope :sorted, -> { order('id DESC') }
end
