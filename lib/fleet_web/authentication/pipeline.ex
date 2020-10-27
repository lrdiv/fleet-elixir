defmodule FleetWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :fleet,
    module: Fleet.Accounts.Guardian,
    error_handler: FleetWeb.Authentication.Errors

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
