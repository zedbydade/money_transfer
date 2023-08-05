defmodule MoneyTransfer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MoneyTransferWeb.Telemetry,
      # Start the Ecto repository
      MoneyTransfer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: MoneyTransfer.PubSub},
      # Start Finch
      {Finch, name: MoneyTransfer.Finch},
      # Start the Endpoint (http/https)
      MoneyTransferWeb.Endpoint
      # Start a worker by calling: MoneyTransfer.Worker.start_link(arg)
      # {MoneyTransfer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MoneyTransfer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MoneyTransferWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
