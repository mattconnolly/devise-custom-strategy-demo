require 'spec_helper'

describe "example request spec" do
  let(:user) { FactoryGirl.create :user }

  context 'notes#index' do
    context 'authenticated' do
      it do
        get notes_url, {}, {'HTTP_X_MY_API' => user.email}
        expect(response).to be_success
        expect(response.body).to include("Listing notes")
      end
    end

    context 'not authenticated' do
      it do
        get notes_url
        expect(response).to be_redirect
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
