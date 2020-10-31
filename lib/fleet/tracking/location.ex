defmodule Fleet.Tracking.Location do
  use Ecto.Schema
  import Ecto.Changeset

  alias Fleet.Accounts.User

  schema "locations" do
    field :lat, :string
    field :lng, :string
    field :latlng, Geo.PostGIS.Geometry
    belongs_to :user, User
    timestamps()
  end

  def changeset(location, user, attrs \\ %{}) do
    location
    |> cast(attrs, [:lat, :lng])
    |> put_assoc(:user, user)
    |> put_latlng(attrs["lat"], attrs["lng"])
    |> validate_required([:lat, :lng, :latlng])
    |> assoc_constraint(:user)
  end

  defp put_latlng(changeset, lat, lng) when is_nil(lat) or is_nil(lng), do: changeset

  defp put_latlng(changeset, lat, lng) do
    latlng = %Geo.Point{coordinates: {lat, lng}, srid: 4326}
    put_change(changeset, :latlng, latlng)
  end
end
