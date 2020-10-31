defmodule FleetWeb.LocationView do
  use JSONAPI.View,  type: "locations"

  def fields do
    [:lat, :lng, :inserted_at]
  end

  def relationships do
    [user: FleetWeb.UserView]
  end
end
