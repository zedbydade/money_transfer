defmodule UserTest do
  use ExUnit.Case 

  alias Ecto.Changeset 
  alias MoneyTransfer.User 

  setup do :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})
  end

  test "insert_user/1 should return an error when invalid params are provied" do
    params = %{
      first_name: "Test",
      last_name: "Test" 
    }

    {:error, changeset} = User.insert_user(params)

    expected_error = {"can't be blank", [validation: :required]}
    assert %Changeset{errors: [cpf: ^expected_error]} = changeset
  end 

  test "insert_user/1 should return :ok tuple when valid params are provided" do 
    params = %{
      first_name: "Test",
      last_name: "Test", 
      cpf: "cpf"
    }

    assert {:ok, %User{}} = User.insert_user(params)
  end
end
