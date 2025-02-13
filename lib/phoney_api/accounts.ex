defmodule PhoneyApi.Accounts do
  use Ash.Domain

  resources do
    resource PhoneyApi.Accounts.User
  end

end
