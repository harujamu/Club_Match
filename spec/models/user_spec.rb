# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context "club_nameカラム" do
      it "空欄でない" do
        user.club_name = ""
        is_expected.to eq false
      end

      it "一意性がある" do
        user.club_name = other_user.club_name
        is_expected.to eq false
      end
    end

    context "captain_last_nameカラム" do
      it "空欄でない" do
        user.captain_last_name = ""
        is_expected.to eq false
      end
    end

    context "captain_first_nameカラム" do
      it "空欄でない" do
        user.captain_first_name = ""
        is_expected.to eq false
      end
    end

    context "emailカラム" do
      it "空欄でない" do
        user.email = ""
        is_expected.to eq false
      end

      it "一意性がある" do
        user.email = other_user.email
        is_expected.to eq false
      end

      it "e-mail表示" do
        user.email = Faker::Internet.email
        is_expected.to eq true
      end
    end

    context "passwordカラム" do
      it "空欄でない" do
        user.password = ""
        is_expected.to eq false
      end

      it "6文字以上" do
        password = Faker::Internet.password(min_length: 6)
        user.password = password
        user.password_confirmation = password
        is_expected.to eq true
      end
    end

    context "prefectureカラム" do
      it "空欄でない" do
        user.prefecture = nil
        is_expected.to eq false
      end

      it "1~47のどれかに当てはまる" do
        user.prefecture = Faker::Number.between(from: 1, to: 47)
        is_expected.to eq true
      end
    end

    context "municipalityカラム" do
      it "空欄でない" do
        user.municipality = ""
        is_expected.to eq false
      end
    end

    context "addressカラム" do
      it "空欄でない" do
        user.address = ""
        is_expected.to eq false
      end

      it "一意性がある" do
        user.address = other_user.address
        is_expected.to eq false
      end
    end

    context "age_groupカラム" do
      it "空欄でない" do
        user.age_group = ""
        is_expected.to eq false
      end

      it "1~5のどれかに当てはまる" do
        user.age_group = Faker::Number.between(from: 1, to: 5)
        is_expected.to eq true
      end
    end

    context "active_statusカラム" do
      it "退会していない" do
        user.active_status = true
        is_expected.to eq true
      end
    end

    context "introductionカラム" do
      it "300文字以下: 300文字は〇" do
      user.introduction = Faker::Lorem.characters(number: 300)
      is_expected.to eq true
    end
      it "300文字以下: 301文字は×" do
        user.introduction = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end
end
