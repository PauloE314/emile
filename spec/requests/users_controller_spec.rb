require 'rails_helper'

RSpec.describe "Api::UsersControllers", type: :request do
  subject { response }
  
  describe "GET /api/users" do
    before { create(:user) }
    before { get api_users_path }

    it { is_expected.to have_http_status(:success) }
    it { expect(JSON.parse(response.body).size).to eq(User.count) }
  end


  describe "POST /api/users" do
    let(:data) { { user: attributes_for(:user) } }
    
    context 'when valid data is passed' do
      before { post api_users_path, params: data }

      it { is_expected.to have_http_status(:created) }
    end

    context 'when invalid data is passed' do
      before { data[:user][:name] = nil }
      before { post api_users_path, params: data }
      
      it { is_expected.to have_http_status(:bad_request) }
    end
  end

  describe "PUT /api/users/:id" do
    let!(:user) { create(:user) }
    let(:data) { { user: { name: 'New name' } } }

    before { put api_user_path(user), params: data, headers: headers }

    context 'when has valid credentials' do
      let(:credentials) { Authentication.create_credentials(user) }
      let(:headers) { { 'Authorization' => credentials[:token] } }

      context 'when valid data is passed' do
        it { is_expected.to have_http_status(:success) }
      end
  
      context 'when invalid data is passed' do
        let(:data) { { user: { name: nil } } }
        it { is_expected.to have_http_status(:bad_request) }
      end
    end

    context 'when has no valid credentials' do
      let(:headers) { { 'Authorization' => nil } }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe "DELETE /api/users/:id" do
    let!(:user) { create(:user) }

    before { delete api_user_path(user), headers: headers }
    
    context 'when has valid credentials' do
      let(:credentials) { credentials_for(user) }
      let(:headers) { { 'Authorization' => credentials[:token] } }

      it { is_expected.to have_http_status(:success) }
    end

    context 'when has no valid credentials' do
      let(:headers) { { 'Authorization' => nil } }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
