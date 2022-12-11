require "rails_helper"

RSpec.describe "Genreモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { genre.valid? }

    let!(:genre) { create(:genre) }
    let(:genre) { build(:genre) }

    context "Nameカラム" do
      it "空欄でない" do
        genre.name = ""
        is_expected.to eq false
      end
    end
  end
end
