defmodule TransactionTest do 
  use ExUnit.Case 
  alias MoneyTransfer.Transaction

  setup do :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})
  end

  describe "when params are valid" do 
    test "should return an :ok tuple when calling insert_transaction/1" do 
      transaction = TransactionMock.create_transaction

      assert {:ok, %Transaction{}} = transaction
    end

    test "should return an error when calling insert_transaction/1 with the same user" do 
      transaction = TransactionMock.create_transaction_with_equal_users

      assert {:ok, %Transaction{}} = transaction
    end
  end
end
