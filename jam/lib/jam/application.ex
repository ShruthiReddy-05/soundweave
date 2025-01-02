defmodule RealTimeJamming.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :ets.new(:sessions, [:named_table, :public, :set])
    children = [
      RealTimeJammingWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:real_time_jamming, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RealTimeJamming.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RealTimeJamming.Finch},
      # Start a worker by calling: RealTimeJamming.Worker.start_link(arg)
      # {RealTimeJamming.Worker, arg},
      # Start to serve requests, typically the last entry
      RealTimeJammingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RealTimeJamming.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RealTimeJammingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

