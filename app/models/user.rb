class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum age_group: { elementary_shool_student: 0, secondary_school_student: 1, high_school_student: 2, college_student: 3, adult: 4 }
  enum prefecture: { hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, hukushima: 6, ibaraki: 7, tochigi: 8, gunma: 9,
                     saitama: 10, chiba: 11, tokyo: 12, kanagawa: 13, niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19,
                     gifu: 20, shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27, nara: 28, wakayama: 29,
                     tottori: 30, shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38, fukuoka: 39,
                     saga: 40, nagasaki: 41, oita: 42, kumamoto: 43, miiyazaki: 44, kagoshima: 45, okinawa: 46 }


  has_one :genre
  
  def captain_name
   captain_last_name + '' + captain_first_name
  end
  
end
