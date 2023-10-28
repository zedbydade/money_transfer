defmodule TransactionMock do
  import UserMock

  alias MoneyTransfer.Transaction

  def create_transaction_with_cashless_sender do
    {:ok, sender} = UserMock.create_cashless_user()
    {:ok, receiver} = UserMock.create_user()

    IO.inspect(receiver)

    params = %{
      sender_id: sender.id,
      receiver_id: receiver.id,
      amount: "100"
    }

    create_transaction(params)
  end

  def create_transaction_with_equal_users do
    {:ok, sender} = UserMock.create_user()

    params = %{
      sender_id: sender.id,
      receiver_id: sender.id,
      amount: "100"
    }

    create_transaction(params)
  end

  def create_transaction do
    {:ok, sender} = UserMock.create_user()
    {:ok, receiver} = UserMock.create_user()

    params = %{
      sender_id: sender.id,
      receiver_id: receiver.id,
      amount: "100"
    }

    create_transaction(params)
  end

  defp create_transaction(params) do
    Transaction.insert_transaction(params)
  end
end
