defmodule FleetWeb.UserControllerTest do
  use FleetWeb.ConnCase
  import FleetWeb.JSONAPIHelpers

  setup [:create_users, :jsonapi_headers]

  defp create_users(context) do
    {:ok, user2} = Fleet.Accounts.create_user(%{"username" => "user2@example.com", "password" => "password"})
    {:ok, user3} = Fleet.Accounts.create_user(%{"username" => "user3@example.com", "password" => "password"})

    case context[:current_user] do
      nil -> {:ok, users: %{user2: user2, user3: user3}}
      user -> {:ok, users: %{user2: user2, user3: user3, current_user: user}}
    end
  end

  describe "index" do
    @tag :auth
    test "list users", %{conn: conn, users: _users} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 4
    end
  end

  describe "show" do
    @tag :auth
    test "show user", %{conn: conn, users: %{user2: user2}} do
      conn = get(conn, Routes.user_path(conn, :show, user2.id))
      assert json_response(conn, 200)
      assert json_response(conn, 200)["data"]["attributes"]["username"] == "user2@example.com"
    end
  end

  describe "create" do
    test "create user", %{conn: conn, users: _users} do
      conn = post(conn, Routes.user_path(conn, :create, data: %{"attributes" => %{"username" => "user4@example.com", "password" => "password"}}))
      assert json_response(conn, 200)
    end
  end
end
