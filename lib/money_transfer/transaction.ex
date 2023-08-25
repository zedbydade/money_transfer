defmodule MoneyTransfer.Transaction do 
  use Ecto.Schema 
  alias MoneyTransfer.Transaction
  alias MoneyTransfer.User 
  import Ecto.Changeset

  schema "transactions" do 
    field :amount, :string 
    belongs_to :sender, User, foreign_key: :sender_id, type: :binary_id 
    belongs_to :receiver, User, foreign_key: :receiver_id, type: :binary_id 

    timestamps()
  end

  def changeset(transaction, attrs) do 
    transaction 
    |> cast(attrs, [:amount, :sender_id, :receiver_id])
    |> validate_required([:amount, :sender_id, :receiver_id])
    |> validate_users([:sender_id, :receiver_id])
  end

  def insert_transaction(attrs) do 
    %Transaction{}
    |> changeset(attrs)
    |> MoneyTransfer.Repo.insert
  end

  def validate_users(changeset, field, _options  \\ []) do 
    validate_change(changeset, field, fn _field, values -> 
      valid? = values[0] !== values[1]
      
      if valid?, do: [], else: [{field, "Sender and Receiver cannot be the same"}]
    end)
  end

end
