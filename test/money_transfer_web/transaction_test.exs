defmodule TransactionTest do
  use ExUnit.Case
  alias Ecto.Changeset
  alias MoneyTransfer.Transaction

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})
  end

  describe "when params are valid" do
    test "should return an :ok tuple when calling insert_transaction/1" do
      transaction = TransactionMock.create_transaction()

      assert {:ok, %Transaction{}} = transaction
    end

    test "should return an error when calling insert_transaction/1 with the same user" do
      {:error, changeset} = TransactionMock.create_transaction_with_equal_users()

      expected_error = {"The receiver cannot be the sender.", []}
      assert %Changeset{errors: [receiver_id: ^expected_error]} = changeset
    end

    test "should return an error when calling insert_transaction/1 with a cashless sender" do
      {:error, changeset} = TransactionMock.create_transaction_with_cashless_sender()

      expected_error = {"The sender doesn't have balance to make that transaction.", []}
      assert %Changeset{errors: [amount: ^expected_error]} = changeset
    end
  end
end
