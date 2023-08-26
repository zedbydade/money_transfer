defmodule UserMock do
  alias MoneyTransfer.User

  def create_user(%{"first_name" => _, "last_name" => _, "cpf" => _} = params) do
    User.insert_user(params)
  end

  def create_user(%{"first_name" => _, "last_name" => _} = params) do
    params = Map.put(params, :cpf, "810.631.740-#{Enum.random(10..99)}")

    User.insert_user(params)
  end

  def create_user do
    params = %{first_name: "Test", last_name: "Test", cpf: "810.631.740-#{Enum.random(10..99)}", balance: 0}

    User.insert_user(params)
  end
end
