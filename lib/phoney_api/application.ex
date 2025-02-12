defmodule PhoneyApi.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [PhoneyApi.Repo]

    opts = [strategy: :one_for_one, name: PhoneyApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
