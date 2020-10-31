defmodule FleetWeb.TokenController do
  use FleetWeb, :controller

  alias Fleet.Accounts

  action_fallback FleetWeb.FallbackController

  def create(conn, %{"username" => username, "password" => password}) do
    with {:ok, token, user} <- Accounts.authenticate_user(username, password) do
      conn
      |> put_status(:created)
      |> render("show.json", %{data: %{token: token, user_id: user.id}})
    end
  end
end
