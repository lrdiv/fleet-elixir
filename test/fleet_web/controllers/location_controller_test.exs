defmodule FleetWeb.LocationControllerTest do
  use FleetWeb.ConnCase
  import FleetWeb.JSONAPIHelpers

  setup [:create_locations, :jsonapi_headers]

  defp create_locations(%{current_user: current_user}) do
    {:ok, location1} = Fleet.Tracking.create_location(current_user, %{"lat" => "88.12345", "lng" => "110.12345"})
    {:ok, location2} = Fleet.Tracking.create_location(current_user, %{"lat" => "89.12345", "lng" => "111.12345"})

    {:ok, other_user} = Fleet.Accounts.create_user(%{"username" => "otheruser@example.com", "password" => "password"})
    {:ok, location3} = Fleet.Tracking.create_location(other_user, %{"lat" => "90.12345", "lng" => "112.12345"})

    {:ok, locations: %{location1: location1, location2: location2, location3: location3}}
  end

  describe "index" do
    @tag :auth
    test "list locations", %{conn: conn} do
      conn = get(conn, Routes.location_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 3
    end

    @tag :auth
    test "list locations - filter by user", %{conn: conn, current_user: current_user} do
      conn = get(conn, Routes.location_path(conn, :index, %{"filter" => %{"user_id" => current_user.id}}))
      assert length(json_response(conn, 200)["data"]) == 2
    end
  end

  describe "create" do
    @tag :auth
    test "create location", %{conn: conn, current_user: current_user} do
      conn = post(conn, Routes.location_path(conn, :create, data: %{"attributes" => %{"lat" => "91.12345", "lng" => "113.12345"}}))
      assert jsonapi_relationship(json_response(conn, 200), "user", current_user.id)
    end
  end
end
