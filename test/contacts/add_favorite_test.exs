defmodule Contacts.AddFavoriteTest do
  use PhoneyApi.DataCase

  alias PhoneyApi.Contacts.Contact
  alias PhoneyApi.Accounts.User

  test "add favorite" do

    assert {:ok, user} = User.create(%{username: "user1", email: "mail@test.com", password: "password"})
    assert {:ok, contact} = Contact.create(%{fullname: "contact1", email: "mycontact@test.com", phone_number: "123456789", address: "1234 test street"})

    assert {:ok, user} = User.toggle_favorite(user, contact.id)

    assert user.username == "user1"
    assert Enum.any?(user.favorites, fn favorite -> favorite.id == contact.id end)

    assert {:ok, user} = User.toggle_favorite(user, contact.id)
    assert Enum.empty?(user.favorites)
  end
end
