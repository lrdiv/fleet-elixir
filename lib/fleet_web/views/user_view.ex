defmodule FleetWeb.UserView do
  use JSONAPI.View,  type: "users"

  def fields do
    [:username]
  end

  def relationships do
    [locations: FleetWeb.LocationView]
  end
end
