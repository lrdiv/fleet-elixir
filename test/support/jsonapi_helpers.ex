defmodule FleetWeb.JSONAPIHelpers do
  def jsonapi_headers(%{conn: conn}) do
    conn = conn
    |> Plug.Conn.put_req_header("accept", "application/vnd.api+json")
    |> Plug.Conn.put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  def jsonapi_relationship(response, type, expected) do
    response["data"]["relationships"][type]["data"]["id"] == to_string(expected)
  end
end
