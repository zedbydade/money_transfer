defmodule MoneyTransfer.RepoCase do
  use ExUnit.CaseTemplate 

  using do
    quote do
      alias MoneyTransfer.Repo

      import Ecto
      import Ecto.Query
      import MoneyTransfer.RepoCase

      # and any other stuff
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)

    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})

    :ok
  end 
end
