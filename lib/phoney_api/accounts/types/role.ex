defmodule PhoneyApi.Accounts.Types.Role do

  use Ash.Type.Enum,
    values: [:verified, :unverified, :admin]
end
