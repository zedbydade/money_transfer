defmodule MoneyTransfer.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do 
      add :amount, :string
      add :sender_id, references(:users, type: :uuid)
      add :receiver_id, references(:users, type: :uuid)

      timestamps()
    end
  end
end
