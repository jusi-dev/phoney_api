defmodule Contacts.CreateContactTest do
  use PhoneyApi.DataCase

  alias PhoneyApi.Contacts.Contact

  test "create contact" do

    assert {:ok, contact} = Contact.create(%{fullname: "contact1", email: "mail@test.com", phone_number: "123456789", address: "1234 test street"})
    assert contact.fullname == "contact1"
    assert contact.email == "mail@test.com"
    assert contact.phone_number == "123456789"
    assert contact.address == "1234 test street"
  end
end
