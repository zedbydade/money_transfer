defmodule UserTest do
  use ExUnit.Case 
  import UserMock

  alias Ecto.Changeset 
  alias MoneyTransfer.User 

  setup do :ok = Ecto.Adapters.SQL.Sandbox.checkout(MoneyTransfer.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MoneyTransfer.Repo, {:shared, self()})
  end

  describe "when params are valid" do 
    test "should return an :ok tuple when calling insert_user/1" do 
      user = UserMock.create_user
      
      assert {:ok, %User{}} = create_user
    end
  end

  describe "when params are invalid" do 

    test "should return an error when calling insert_user/1, and cpf is missing" do
      params = %{
        first_name: "Test",
        last_name: "Test" 
      }

      {:error, changeset} = User.insert_user(params)

      expected_error = {"can't be blank", [validation: :required]}
      assert %Changeset{errors: [cpf: ^expected_error]} = changeset
    end 

    test "should return an error when calling insert_user/1, and cpf is present but invalid" do
      params = %{
        first_name: "Test",
        last_name: "Test", 
        cpf: "Not A Cpf"
      }

      {:error, changeset} = User.insert_user(params)

      expected_format_error = {"has invalid format", [validation: :format]} 
      expected_length_error = {"should be %{count} character(s)",
        [count: 14, validation: :length, kind: :is, type: :string]}
      assert %Changeset{errors: [cpf: ^expected_length_error, cpf: ^expected_format_error]} = changeset
    end 

  end
end
