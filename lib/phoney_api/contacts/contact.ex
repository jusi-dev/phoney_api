defmodule PhoneyApi.Contacts.Contact do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: PhoneyApi.Contacts

    alias PhoneyApi.Contacts

    attributes do
      uuid_primary_key :id

      attribute :fullname, :string, public?: true, allow_nil?: false
      attribute :phone_number, :string, public?: true, allow_nil?: false
      attribute :email, :string, public?: true
      attribute :address, Contacts.Address do
        public? true
      end

      create_timestamp :created_at
      update_timestamp :updated_at
    end

    code_interface do
      define :create
      define :read
      define :search, args: [:query]
    end

    actions do
      defaults [:read, :destroy, create: :*, update: :*]

      read :search do
        argument :query, :string

        filter expr(
        or: [
              {:fullname, contains: ^arg(:query)},
              {:phone_number, contains: ^arg(:query)}
            ]
      )
      end
    end

    postgres do
      table "contacts"
      repo PhoneyApi.Repo
    end
end
