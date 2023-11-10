class Address < ApplicationRecord
  belongs_to :donation

  # validates :postal_code,presence:true, format:{with:/\A[0-9]{3}-[0-9]{4}\z/i}
  # validates :prefecture,presence:true, numericality:{other_than:0}
end
