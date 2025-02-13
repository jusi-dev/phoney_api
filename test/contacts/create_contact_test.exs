defmodule Contacts.CreateContactTest do
  use PhoneyApi.DataCase

  alias PhoneyApi.Contacts.Contact

  test "create contact" do
    assert {:ok, contact} = Contact.create(%{
      fullname: "contact1",
      email: "mail@test.com",
      phone_number: "123456789",
      address: %{
        street: "1234 test street",
        city: "test city",
        state: "test state",
        zip: "12345"
      }
    })
    assert contact.fullname == "contact1"
    assert contact.email == "mail@test.com"
    assert contact.phone_number == "123456789"
    assert contact.address.street == "1234 test street"
    assert contact.address.city == "test city"
    assert contact.address.state == "test state"
    assert contact.address.zip == "12345"
  end

  test "create contact with invalid address" do
    assert {:error, _} = Contact.create(%{
      fullname: "contact1",
      email: "mail@test.com",
      phone_number: "123456789",
      address: %{}
    })
  end

  test "create contact without fullname" do
    assert {:error, _} = Contact.create(%{
      email: "mail@test.com",
      phone_number: "123456789",
      address: %{
        street: "1234 test street",
        city: "test city",
        state: "test state",
        zip: "12345"
      }
    })
  end

  test "create contact without phonenumber" do
    assert {:error, _} = Contact.create(%{
      fullname: "contact1",
      email: "mail@test.com",
      address: %{
        street: "1234 test street",
        city: "test city",
        state: "test state",
        zip: "12345"
      }
    })
  end
end
