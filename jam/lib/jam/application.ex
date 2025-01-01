defmodule Jam.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JamWeb.Telemetry,
      Jam.Repo,
      {DNSCluster, query: Application.get_env(:jam, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Jam.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Jam.Finch},
      # Start a worker by calling: Jam.Worker.start_link(arg)
      # {Jam.Worker, arg},
      # Start to serve requests, typically the last entry
      JamWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jam.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JamWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
