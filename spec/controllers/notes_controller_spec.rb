require 'rails_helper'

RSpec.describe NotesController do
  let(:current_user) { create(:user) }
  let(:valid_attributes) { attributes_for(:note) }
  let(:params_with_note) { { locale: :en , note: valid_attributes } }

  #
  # index action
  #

  describe "index action visited by" do
    after(:each) do
      get :index, params: { locale: :en }
      expect(response).to have_http_status(:success)
    end

    context "a guest" do
      it "succeeds" do
      end
    end

    context "a user" do
      it "succeeds" do
        sign_in current_user
      end
    end
  end

  #
  # show actions
  #

  %i(show review quiz).each do |type|
    describe "#{type} route visited by" do
      let!(:note) { create(:note) }

      after(:each) do
        get type, params: { locale: :en, id: note.to_param }
        expect(response).to have_http_status(:success)
      end

      context "a guest" do
        it "succeeds" do
        end
      end

      context "a user" do
        it "succeeds" do
          sign_in current_user
        end
      end
    end
  end

  #
  # new/create actions
  #

  describe "new/create action visited by" do
    context "a guest" do
      after(:each) { expect_to_redirect_to_login_path }

      it "new fails" do
        get :new, params: { locale: :en }
      end

      it "create fails" do
        expect { post :create, params_with_note }.to_not change(Note, :count)
      end
    end

    context "a user" do
      before(:each) { sign_in current_user }

      it "new succeeds" do
        get :new, params: { locale: :en }
        expect(response).to have_http_status(:success)
      end

      it "create succeeds" do
        expect { post :create, params_with_note }.to change { Note.count }.from(0).to(1)
        expect(response).to redirect_to(note_path(Note.first, locale: :en ))
        expect(flash[:notice]).to eq(t("note.created"))
      end
    end
  end

  #
  # edit/update actions
  #

  describe "edit/update action visited by" do
    context "a guest" do
      let!(:note) { create(:note) }
      after(:each) { expect_to_redirect_to_login_path }

      it "edit fails" do
        get :edit, params: { locale: :en, id: note.to_param }
      end

      it "update fails" do
        patch :update, params: { locale: :en, id: note.to_param, note: valid_attributes }
        expect(Note.first).to eq(note)
      end
    end

    context "a user does not own the note" do
      let!(:note) { create(:note) }
      before(:each) { sign_in current_user }
      after(:each) do
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq(t("pundit.note_policy.edit?"))
      end

        it "edit fails" do
          get :edit, params: { locale: :en, id: note.to_param }
        end

        it "patch fails" do
          patch :update, params: { locale: :en, id: note.to_param, note: valid_attributes }
          expect(Note.first).to eq(note)
        end
      end

    context "a user owns the note" do
      let!(:note) { create(:note, user: current_user) }
      before(:each) { sign_in current_user }

      it "edit succeeds when the user owns the note" do
        get :edit, params: { locale: :en, id: note.to_param }
        expect(response).to have_http_status(:success)
      end

      it "patch succeeds when the user owns the note" do
        patch :update, params: { locale: :en, id: note.to_param, note: valid_attributes }
        expect(Note.first.title).not_to eq(note.title)
        expect(flash[:notice]).to eq(t("note.updated"))
      end
    end
  end
end
