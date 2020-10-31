defmodule FleetWeb.UserController do
  use FleetWeb, :controller

  plug JSONAPI.QueryParser,
       view: FleetWeb.UserView

  alias Fleet.Accounts

  def index(conn, _params) do
    with data <- Accounts.list_users() do
      render(conn, "index.json", data: data)
    end
  end

  def show(conn, %{"id" => id}) do
    with data <- Accounts.get_user!(id) do
      render(conn, "show.json", data: data)
    end
  end

  def create(conn, params) do
    with {:ok, data} <- Accounts.create_user(params) do
      render(conn, "show.json", data: data)
    end
  end
end
