class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :establishments, class_name: "Establishment"

  has_many :qualifications, class_name: "Qualification"
  has_many :qualified_establishments, through: :qualifications

  has_many :likes, class_name: "Qualification"
  has_many :liked_establishments, through: :likes
end
