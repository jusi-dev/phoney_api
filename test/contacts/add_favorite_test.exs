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

  test "add multiple favorites" do
    {:ok, user} =
      User.create(%{
        username: "user1",
        email: "mail@test.com",
        password: "password"
      })

    {:ok, contact1} =
      Contact.create(%{
        fullname: "contact1",
        email: "mycontact@test.com",
        phone_number: "123456789",
        address: "1234 test street"
      })

    {:ok, contact2} =
      Contact.create(%{
        fullname: "contact2",
        email: "mycontact2@test.com",
        phone_number: "123456789",
        address: "1234 test street"
      })

    assert {:ok, user} = User.toggle_favorite(user, contact1.id)
    assert [favorite] = user.favorites
    assert favorite.id == contact1.id

    assert {:ok, user} = User.toggle_favorite(user, contact2.id)
    assert [favorite1, favorite2] = user.favorites
    assert favorite1.id == contact1.id
    assert favorite2.id == contact2.id

    assert {:ok, user} = User.toggle_favorite(user, contact1.id)
    assert [favorite] = user.favorites
    assert favorite.id == contact2.id
  end

  test "multiple users add 'mc' favorites" do
    {:ok, user1} =
      User.create(%{
        username: "user1",
        email: "mail@test.com",
        password: "password"
      })

    {:ok, user2} =
      User.create(%{
        username: "user2",
        email: "mail2@test.com",
        password: "password"
      })

    {:ok, contact1} =
      Contact.create(%{
        fullname: "contact1",
        email: "mycontact@test.com",
        phone_number: "123456789",
        address: "1234 test street"
      })

    {:ok, contact2} =
      Contact.create(%{
        fullname: "contact2",
        email: "mycontact2@test.com",
        phone_number: "123456789",
        address: "1234 test street"
      })

    assert {:ok, user1} = User.toggle_favorite(user1, contact1.id)
    assert [favorite] = user1.favorites
    assert favorite.id == contact1.id

    assert {:ok, user2} = User.toggle_favorite(user2, contact1.id)
    assert {:ok, user2} = User.toggle_favorite(user2, contact2.id)
    assert [favorite, favorite2] = user2.favorites
    assert favorite.id == contact1.id
    assert favorite2.id == contact2.id

    assert {:ok, user1} = User.toggle_favorite(user1, contact1.id)
    assert [] = user1.favorites

    assert {:ok, user2} = User.toggle_favorite(user2, contact1.id)
    assert [favorite2] = user2.favorites
    assert favorite2.id == contact2.id

  end
end
