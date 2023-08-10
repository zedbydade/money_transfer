defmodule TransferMoney.Transaction do 
  use Ecto.Schema 

  schema "transactions" do 
    field :amount, :integer 
    belongs_to :user, MoneyTransfer.Movie
  end

  def changeset(transaction, attrs) do 
    transaction 
    |> cast(attrs, [:amount, :sender_id, :receiver_id])
    |> validate_required([:amount, :sender_id, :receiver_id])
  end

  def insert_transaction(attrs) do 
    %Transaction{}
    |> changeset(attrs)
    |> MoneyTransfer.Repo.insert
  end
end
