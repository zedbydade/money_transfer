defmodule MoneyTransfer.User do
  use Ecto.Schema
  alias MoneyTransfer.User
  alias MoneyTransfer.Transaction
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :cpf, :string
    field :balance, :integer
    has_many :sender_transaction, Transaction, foreign_key: :sender_id
    has_many :receiver_transaction, Transaction, foreign_key: :receiver_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :cpf, :balance])
    |> validate_required([:first_name, :last_name, :cpf, :balance])
    |> unique_constraint(:cpf)
    |> validate_format(:cpf, ~r/(\d{3})?(\d{3})?(\d{3})?(\d{2})/)
    |> validate_length(:first_name, min: 3)
    |> validate_length(:last_name, min: 3)
    |> validate_length(:cpf, is: 14)
  end

  def insert_user(attrs) do
    %User{}
    |> changeset(attrs)
    |> MoneyTransfer.Repo.insert()
  end
end
