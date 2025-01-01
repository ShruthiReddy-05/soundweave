defmodule Jam.Repo do
  use Ecto.Repo,
    otp_app: :jam,
    adapter: Ecto.Adapters.Postgres
end
