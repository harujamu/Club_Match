#frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Siteモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { site.valid? }
    
    let(:user) { create(:user) }
    let!(:site) { build(:site) }
    
     context 'prefectureカラム' do
      it '空欄でないこと' do
        site.prefecture = ''
        is_expected.to eq false
      end
    end

    context 'municipalityカラム' do
      it '空欄でないこと' do
        site.municipality = ''
        is_expected.to eq false
      end
    end
    
    context 'addressカラム' do
      it '空欄でないこと' do
        site.address = ''
        is_expected.to eq false
      end
    end
  end

end