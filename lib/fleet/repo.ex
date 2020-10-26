defmodule Fleet.Repo do
  use Ecto.Repo,
    otp_app: :fleet,
    adapter: Ecto.Adapters.Postgres
end
