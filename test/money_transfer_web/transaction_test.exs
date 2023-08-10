defmodule TransactionTest do 
  use ExUnit.Case 

  alias Ecto.Changeset 
  alias MoneyTransfer.Transaction

  setup do :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})
  end

  

end
