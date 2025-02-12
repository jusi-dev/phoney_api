defmodule PhoneyApiTest do
  use ExUnit.Case
  doctest PhoneyApi

  test "greets the world" do
    assert PhoneyApi.hello() == :world
  end
end
