defmodule PhoneyApi.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: PhoneyApi.Accounts

  identities do
    identity :email, :email
  end


  attributes do
    uuid_primary_key :id

    attribute :email, :string, public?: true, allow_nil?: false
    attribute :username, :string, public?: true, allow_nil?: false
    attribute :password, :string do
      allow_nil? false
      public? true
      constraints [
        min_length: 8
      ]
    end
    attribute :role, PhoneyApi.Accounts.Types.Role, public?: true

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    many_to_many :favorites, PhoneyApi.Contacts.Contact do
      through PhoneyApi.Contacts.Favorite
      source_attribute_on_join_resource :user_id
      destination_attribute_on_join_resource :contact_id
      public? true
    end
  end

  code_interface do
    define :create
    define :toggle_favorite, action: :favorite_contact, args: [:contact_id]
  end

  actions do
    defaults [:read, :destroy, update: :*]

    create :create do
      primary? true
      accept [:email, :username, :password, :role]

      # Not sure if needed since allow_nil is false
      validate present(:email)
      validate present(:username)
    end

    update :favorite_contact do
      require_atomic? false
      argument :contact_id, :uuid

      change manage_relationship(:contact_id, :favorites, on_lookup: :relate, on_no_match: :create, on_match: :destroy, on_missing: :ignore)
    end
  end

  postgres do
    table "users"
    repo PhoneyApi.Repo
  end
end
