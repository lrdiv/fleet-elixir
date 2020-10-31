defmodule Fleet.Repo.Migrations.AddLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :lat, :string
      add :lng, :string
      add :latlng, :geometry
      add :user_id, references(:users)

      timestamps()
    end
  end
end
