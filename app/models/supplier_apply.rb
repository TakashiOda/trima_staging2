class SupplierApply < ApplicationRecord
  validates :company, presence: true, length: { in: 3..50 }
  validates :name, presence: true, length: { in: 2..30 }
  validates :prefecture, presence: true
  validates :town, presence: true
  validates :address, presence: true, length: { in: 6..80 }
  validates :phone, presence: true, length: { in: 10..11 }
  validates :email, uniqueness: true, presence: true
  validates :agree_term, acceptance: true
end
