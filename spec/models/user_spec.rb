#frozen_string_literal: true

require 'rails_helper'

  describe 'Userモデルのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'club_nameカラム' do
      it '空欄でない' do
        user.club_name = ""
        is_expected.to eq false
      end
      
      it '一意性がある' do
        user.club_name = other_user.club_name
        is_expected.to eq false
      end
    end
    
    context 'captain_last_nameカラム' do
      it '空欄でない' do
        user.captain_last_name = ""
        is_expected.to eq false
      end
    end
    
    context 'captain_first_nameカラム' do
      it '空欄でない' do
        user.captain_first_name = ""
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でない' do
        user.email = ""
        is_expected.to eq false
      end
      
      it '一意性がある' do
        user.e-mail = other_user.e-mail
        is_expected.to eq false
      end
      
      it 'e-mail表示' do
        user.email = Faker::Internet.email
        is_expected.to eq true
      end
    end
    
    context 'encrypted_passwordカラム' do
      it '空欄でない' do
        user.encrypted_password = ""
        is_expected.to eq false
      end
      
      it '6文字以上,6文字は〇' do
        user.encrypted_password = Faker::Lorem.characters(number:6)
        is_expected.to eq true 
      end
      
      it '6文字以上,7文字は×' do
        user.encrypted_password = Faker::Lorem.characters(number:７)
        is_expected.to eq false 
      end
    end
    
    context 'prefectureカラム' do
      it '空欄でない' do
        user.prefecture = ""
        is_expected.to eq false
      end
      
      it '1~47のどれかに当てはまる' do
        user.prefecture = Faker::Lorem.characters(number:1)
        is_expected.to be_between(1, 47).inclusive
      end
    end
    
    context 'municipalityカラム' do
      it '空欄でない' do
        user.municipality = ""
        is_expected.to eq false
      end
    end
    
    context 'addressカラム' do
      it '空欄でない' do
        user.address = ""
        is_expected.to eq false
      end
      
      it '一意性がある' do
        user.address = other_user.address
        is_expected.to eq false
      end
    end
    
    context 'age_groupカラム' do
      it '空欄でない' do
        user.age_group = ""
        is_expected.to eq false
      end
      
      it '1~5のどれかに当てはまる' do
        user.prefecture = Faker::Lorem.characters(number:1)
        is_expected.to be_between(1, 5).inclusive
      end
    end
    
    context 'active_statusカラム' do
      it '退会していない' do
        user.active_status = true
        is_expected.to eq true
      end
    end
    
    context 'introductionカラム' do
      it '300文字以下: 300文字は〇' do
      user.introduction = Faker::Lorem.characters(number: 300)
      is_expected.to eq true
    end
    it '300文字以下: 301文字は×' do
      user.introduction = Faker::Lorem.characters(number: 301)
      is_expected.to eq false
    end

    end
  end
