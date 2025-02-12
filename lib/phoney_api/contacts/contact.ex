defmodule PhoneyApi.Contacts.Contact do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: PhoneyApi.Contacts

    attributes do
      uuid_primary_key :id

      attribute :fullname, :string, public?: true
      attribute :phone_number, :string, public?: true
      attribute :email, :string, public?: true
      attribute :address, :string, public?: true

      create_timestamp :created_at
      update_timestamp :updated_at
    end

    actions do
      defaults [:read, :destroy, create: :*, update: :*]
    end

    code_interface do
      define :create
    end


    postgres do
      table "contacts"
      repo PhoneyApi.Repo
    end
end
