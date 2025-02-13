defmodule Contacts.SearchContactTest do
  use PhoneyApi.DataCase

  alias PhoneyApi.Contacts.Contact

  test "search contact" do
    PhoneyApi.Accounts.User.create(%{
      email: "john@example.com",
      username: "john_doe",
      password: "password123"
    })

    # Create some contacts
    PhoneyApi.Contacts.Contact.create(%{
      fullname: "Alice Smith",
      phone_number: "+1234567890",
      email: "alice@example.com",
      address: %{
        street: "1234 test street",
        city: "test city",
        state: "test state",
        zip: "12345"
      }
    })

    PhoneyApi.Contacts.Contact.create(%{
      fullname: "Bob Johnson",
      phone_number: "+0987654321",
      email: "bob@example.com",
      address: %{
        street: "1234 test street",
        city: "test city",
        state: "test state",
        zip: "12345"
      }
    })

    {:ok, contacts} = Contact.read()
    assert Enum.any?(contacts, fn contact -> contact.fullname == "Alice Smith" end)
    assert Enum.any?(contacts, fn contact -> contact.fullname == "Bob Johnson" end)

    {:ok, search_result} = Contact.search("Alice")
    assert Enum.any?(search_result, fn contact -> contact.fullname == "Alice Smith" end)
    assert Enum.any?(search_result, fn contact -> contact.fullname != "Bob Johnson" end)
  end
end
