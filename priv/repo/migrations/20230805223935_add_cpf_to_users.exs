defmodule MoneyTransfer.Repo.Migrations.AddCpfToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do 
      add :cpf, :string
    end

  end
end
