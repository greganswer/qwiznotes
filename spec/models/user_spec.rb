require 'rails_helper'

RSpec.describe User do
  ## VALIDATIONS

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  context "validates uniqueness of" do
    let(:users) { create_list :user, 2 }

    it "name" do
      expect(users[1].update name: users[0].name).to be false
    end

    it "email" do
      expect(users[1].update email: users[0].email).to be false
    end
  end

  # FIXME: the regext which worked in Rails 4.2 is no longer working
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
end
