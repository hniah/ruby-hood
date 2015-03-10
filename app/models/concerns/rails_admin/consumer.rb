module Concerns::RailsAdmin::Consumer
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        field :email
        field :password
        field :password_confirmation
        field :name
        field :phone
      end

      list do
        field :id
        field :email
        field :name
        field :phone
      end

      show do
        field :id
        field :email
        field :name
        field :phone
      end
    end
  end
end
