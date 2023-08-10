ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, :manual)

def create_user do 
  params = %{
    first_name: "Test",
    last_name: "Test", 
    cpf: "810.631.740-#{Enum.random(10..99)}"
  }

  User.insert_user(params)
end
