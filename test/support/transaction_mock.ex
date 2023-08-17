defmodule TransactionMock do 
  import UserMock

  alias MoneyTransfer.Transaction

  def create_transaction do 
    UserMock.create_user
    UserMock.create_user

    params = %{
      sender_id: 1,
      receiver_id: 1,
      amount: '100'
    }

    Transaction.insert_transaction(params)
  end
end
