defmodule PhoneyApi.Contacts do
  use Ash.Domain

  resources do
    resource PhoneyApi.Contacts.Contact
    resource PhoneyApi.Contacts.Favorite
  end

end
