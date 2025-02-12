defmodule PhoneyApi.Contacts.Favorite do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: PhoneyApi.Contacts

  relationships do
    belongs_to :user, PhoneyApi.Accounts.User, primary_key?: true, allow_nil?: false
    belongs_to :contact, PhoneyApi.Contacts.Contact, primary_key?: true, allow_nil?: false
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  postgres do
    table "favorites"
    repo PhoneyApi.Repo
  end
end
