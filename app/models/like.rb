class Like < ApplicationRecord
  belongs_to :establishment, class_name: "Establishment", foreign_key: "establishment_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"
end
