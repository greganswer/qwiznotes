require 'rails_helper'

RSpec.describe User do
  let(:current_user) { create(:user) }

  ## VALIDATIONS

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  it "can be found by hashid" do
    user = create(:user)
    hashid = Hashids.new(Rails.application.secrets.secret_key_base, 8).encode(user.id)
    expect(user.to_param).to eq(hashid)
    expect(User.find_by_hashid(hashid)).to eq(user)
  end

  context "validates uniqueness of" do
    let(:users) { create_list :user, 2 }

    it "name" do
      expect(users[1].update name: users[0].name).to be false
    end

    it "email" do
      expect(users[1].update email: users[0].email).to be false
    end
  end

  ["bad name", "bad.name", "bad@name"].each do |name|
    it "displays invalid notice when name is '#{name}'" do
      record = build(:user, name: name)
      record.save
      invalid_notice = t("activerecord.errors.models.user.attributes.name.invalid")
      expect(record.errors[:name]).to eq [invalid_notice]
    end
  end

  context "creates a unique name" do
    it "from email if name is not present" do
      user = create(:user)
      expect(user.name).to eq(user.email.split("@").first)
    end

    it "from email and converts '.' character to '-' character" do
      user = create(:user, email: 'john.doe@mail.com')
      expect(user.name).to eq('john-doe')
    end

    it "accepts a name input" do
      user = create(:user, name: 'john')
      expect(user.name).to eq('john')
    end
  end

  it "#to_s" do
    user = User.new(name: "Mike")
    expect(user.to_s).to eq(user.name)
  end

  context "#owns?" do
    it "it returns true if the user owns the model" do
      expect(current_user.owns?(create(:note, user: current_user))).to be true
    end

    it "returns false if the user DOES NOT own the model" do
      expect(current_user.owns?(create(:note))).to be false
    end
  end
end
