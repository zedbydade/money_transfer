defmodule MoneyTransfer.Repo do
  use Ecto.Repo,
    otp_app: :money_transfer,
    adapter: Ecto.Adapters.Postgres
end
