defmodule MoneyTransfer.User do
  use Ecto.Schema
  alias MoneyTransfer.User 
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :cpf, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :cpf])
    |> validate_required([:first_name, :last_name, :cpf])
  end

  def insert_user(attrs) do 
    %User{}
    |> changeset(attrs)
    |> MoneyTransfer.Repo.insert
  end
end
