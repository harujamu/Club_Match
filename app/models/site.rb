# frozen_string_literal: true

class Site < ApplicationRecord
  enum prefecture: {
    hokkaido: 1,
    aomori: 2,
    iwate: 3,
    miyagi: 4,
    akita: 5,
    yamagata: 6,
    hukushima: 7,
    ibaraki: 8,
    tochigi: 9,
    gunma: 10,
    saitama: 11,
    chiba: 12,
    tokyo: 13,
    kanagawa: 14,
    niigata: 15,
    toyama: 16,
    ishikawa: 17,
    fukui: 18,
    yamanashi: 19,
    nagano: 20,
    gifu: 21,
    shizuoka: 22,
    aichi: 23,
    mie: 24,
    shiga: 25,
    kyoto: 26,
    osaka: 27,
    hyogo: 28,
    nara: 29,
    wakayama: 30,
    tottori: 31,
    shimane: 32,
    okayama: 33,
    hiroshima: 34,
    yamaguchi: 35,
    okushima: 36,
    kagawa: 37,
    ehime: 38,
    kochi: 39,
    fukuoka: 40,
    saga: 41,
    nagasaki: 42,
    oita: 43,
    kumamoto: 44,
    miiyazaki: 45,
    kagoshima: 46,
    okinawa: 47
  }


  belongs_to :user

  validates :prefecture, presence: true
  validates :municipality, presence: true
  validates :address, presence: true

  def site_name
    prefecture_i18n + " " + municipality + " " + address
  end
end
