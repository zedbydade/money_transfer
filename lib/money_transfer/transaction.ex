defmodule MoneyTransfer.Transaction do
  use Ecto.Schema
  alias MoneyTransfer.Transaction
  alias MoneyTransfer.User
  alias MoneyTransfer.Repo
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
    |> validate_receiver()
    |> validate_sender()
  end

  def insert_transaction(attrs) do
    %Transaction{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def validate_sender(changeset) do 
    sender = Repo.get!(User, get_change(changeset, :sender_id)) 
    balance = sender.balance / 100
    amount = Integer.parse(get_change(changeset, :amount)) 
    valid? = balance >= elem(amount, 0)
    if valid?,
      do: changeset,
      else: add_error(changeset, :amount, "The sender doesn't have balance to make that transaction.")
  end

  def validate_receiver(changeset) do
    sender_id = get_change(changeset, :sender_id)
    receiver_id = get_change(changeset, :receiver_id)
    valid? = sender_id !== receiver_id

    if valid?,
      do: changeset,
      else: add_error(changeset, :receiver_id, "The receiver cannot be the sender.")
  end
end
