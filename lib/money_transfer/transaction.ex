defmodule MoneyTransfer.Transaction do 
  use Ecto.Schema 
  alias MoneyTransfer.Transaction
  alias MoneyTransfer.User 
  import Ecto.Changeset

  schema "transactions" do 
    field :amount, :string 
    belongs_to :sender, User, foreign_key: :sender_id 
    belongs_to :receiver, User, foreign_key: :receiver_id 
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
