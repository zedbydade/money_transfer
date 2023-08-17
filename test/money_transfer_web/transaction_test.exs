defmodule TransactionTest do 
  use ExUnit.Case 
  import UserMock

  alias Ecto.Changeset 
  alias MoneyTransfer.Transaction

  setup do :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})
  end

  describe "when params are valid" do 
    test "should return an :ok tuple when calling insert_transaction/1" do 
      transaction = TransactionMock.create_transaction

      assert {:ok, %Transaction{}} = transaction
    end
  end
end
