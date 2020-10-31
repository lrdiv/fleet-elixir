defmodule FleetWeb.LocationController do
  use FleetWeb, :controller

  plug JSONAPI.QueryParser,
       view: FleetWeb.LocationView,
       filter: ~w(user_id)

  alias Fleet.Tracking

  def index(conn, params) do
    data = Tracking.list_locations(params)
    render(conn, "index.json", data: data)
  end

  def create(conn, params) do
    with user <- Guardian.Plug.current_resource(conn),
         {:ok, data} <- Tracking.create_location(user, params) do
      render(conn, "show.json", data: data)
    end
  end
end
