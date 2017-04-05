module ControllerHelpers
  def expect_to_redirect_to_login_path
    expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq(t("devise.failure.unauthenticated"))
  end
end
