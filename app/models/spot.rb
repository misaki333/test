class Spot < ApplicationRecord
	acts_as_paranoid
	attachment :image

	has_many :posts
	belongs_to :category

	scope :autocomplete, ->(term) {
		where("name LIKE ?" , "#{term}%").order(:name)
	}

	geocoded_by :address
	after_validation :geocode
	# モデル登録時と住所(address)変更時にgeocoderにより、緯度・経度のデータが登録・更新される。

	has_many :likes, dependent: :destroy
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

	validates :name, presence: true
	validates :address, presence: true
	validates :content, presence: true
end