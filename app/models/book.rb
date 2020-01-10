class Book < ApplicationRecord
  belongs_to :user
  # lamdaメソッド(->; アロー演算子)はブロック(何らかの処理)をオブジェクト化できる。
  # procメソッドとの違いは引数のチェックがあるかどうか。ラムダのが制約がきつい。引数の数に過不足があるとエラーが発生する。
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :author, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :good_point, presence: true, length: { maximum: 500 }
  validate :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
