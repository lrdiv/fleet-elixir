defmodule Fleet.Tracking do
  import Ecto.Query, warn: false
  import Geo.PostGIS

  alias Fleet.Repo
  alias Fleet.Tracking.Location

  def list_locations(_ \\ %{})

  def list_locations(%{"filter" => filters}) do
    query = from loc in Location,
            order_by: [desc: :inserted_at],
            where: ^filter_where(filters)
    Repo.all(query)
  end

  def list_locations(%{"bounds" => %{"sw" => sw, "ne" => ne}}) do
    bounds = parse_latlng_query({sw, ne})
    query = from loc in Location,
            order_by: [desc: :inserted_at],
            distinct: loc.user_id,
            where: st_contains(^bounds_box(bounds), loc.latlng)
    Repo.all(query)
  end

  def list_locations(_) do
    Repo.all(Location, order_by: [desc: :inserted_at])
  end

  def create_location(user, attrs) do
    %Location{}
    |> Location.changeset(user, attrs)
    |> Repo.insert()
  end

  defp filter_where(filters) do
    Enum.reduce(filters, dynamic(true), fn
      {"user_id", user_id}, dynamic ->
        dynamic([loc], ^dynamic and loc.user_id == ^String.to_integer(user_id))
      {"after_time", after_time}, dynamic ->
        dynamic([loc], ^dynamic and loc.inserted_at > ^DateTime.from_unix!(after_time))
      {_, _}, dynamic -> dynamic
    end)
  end

  defp bounds_box({sw, ne}) do
    %Geo.Polygon{srid: 4326, coordinates: [[
      {elem(sw, 0), elem(sw, 1)},
      {elem(sw, 0), elem(ne, 1)},
      {elem(ne, 0), elem(ne, 1)},
      {elem(ne, 0), elem(sw, 1)},
      {elem(sw, 0), elem(sw, 1)}
    ]]}
  end

  defp parse_latlng_query(bounds) do
    bounds
    |> Tuple.to_list()
    |> Enum.map(fn point -> String.split(point, ",") end)
    |> Enum.map(fn coords -> List.to_tuple(coords) end)
    |> List.to_tuple
  end
end
