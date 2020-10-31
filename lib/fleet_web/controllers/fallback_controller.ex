defmodule FleetWeb.FallbackController do
  use FleetWeb, :controller

  alias Ecto.Changeset

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(FleetWeb.ErrorView)
    |> render("error.json", %{status: "422", title: "Unprocessable", detail: changeset_errors(changeset)})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(FleetWeb.ErrorView)
    |> render("error.json", %{status: "404", title: "Not Found"})
  end

  def call(conn, {:error, :invalid_credentials}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(FleetWeb.ErrorView)
    |> render("error.json", %{status: "401", title: "Unauthorized"})
  end

  def call(conn, {:error, :unauthorized}) do
    call(conn, {:error, :invalid_credentials})
  end

  def call(conn, {:error, title}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(FleetWeb.ErrorView)
    |> render("error.json", %{status: "500", title: title})
  end

  defp changeset_errors(changeset) do
    Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
