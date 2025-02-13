defmodule PhoneyApi.Contacts.Address do
  use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :street, :string, public?: true
    attribute :city, :string, public?: true
    attribute :state, :string, public?: true
    attribute :zip, :string, public?: true
  end

  validations do
    validate present([:street, :city, :state, :zip], at_least: 1)
  end

  calculations do
    calculate :full_address, :string, concat([:street, :city, :state, :zip], separator: ", ")
  end
end
