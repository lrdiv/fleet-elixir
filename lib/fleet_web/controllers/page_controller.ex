defmodule FleetWeb.PageController do
  use FleetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
