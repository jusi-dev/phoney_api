defmodule Accounts.CreateUserTest do
  use PhoneyApi.DataCase

  alias PhoneyApi.Accounts.User

  test "create user" do
    assert {:ok, user} = User.create(%{username: "user1", email: "mail@test.com", password: "password", role: :admin})

    assert user.username == "user1"
    assert user.email == "mail@test.com"
    assert user.password == "password"
    assert user.role == :admin
  end

  test "create user with invalid password" do
    assert {:error, _} = User.create(%{username: "user1", email: "mail@test.com", password: "pass", role: :admin})
  end

  test "create multiple user with same email" do
    assert {:ok, _} = User.create(%{username: "user1", email: "mail@test.com", password: "password", role: :admin})
    assert {:error, _} = User.create(%{username: "user2", email: "mail@test.com", password: "password", role: :admin})
  end

  test "create user with empty email" do
    assert {:error, _} = User.create(%{username: "user1", email: "", password: "password", role: :admin})
  end

  test "create user with empty username" do
    assert {:error, _} = User.create(%{username: "", email: "mail@test.com", password: "password", role: :admin})
  end

  test "create user with invalid role" do
    assert {:error, _} = User.create(%{username: "user1", email: "mail@test.com", password: "password", role: :invalid_role})
  end
end
