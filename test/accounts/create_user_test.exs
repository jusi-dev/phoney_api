defmodule Accounts.CreateUserTest do
  use PhoneyApi.DataCase

  alias PhoneyApi.Accounts.User

  test "create user" do

    assert {:ok, user} = User.create(%{username: "user1", email: "mail@test.com", password: "password"})
    assert user.username == "user1"
    assert user.email == "mail@test.com"
    assert user.password == "password"
  end
end
