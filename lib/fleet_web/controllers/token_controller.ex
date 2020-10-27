defmodule FleetWeb.TokenController do
  use FleetWeb, :controller

  plug JSONAPI.QueryParser, view: FleetWeb.TokenView

  alias Fleet.Accounts

  def create(conn, %{"username" => username, "password" => password}) do
    with {:ok, token, user} <- Accounts.authenticate_user(username, password) do
      conn
      |> put_status(:created)
      |> render("show.json", %{data: %{token: token, user_id: user.id}})
    end
  end

end
