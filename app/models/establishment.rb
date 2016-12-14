class Establishment < ApplicationRecord

  has_many :qualifications, class_name: "Qualification"
  has_many :user_qualifications, through: :qualifications

  has_many :likes, class_name: "Like"
  has_many :user_likes, through: :likes

  belongs_to :user, class_name: "User", foreign_key: "user_id"
end
