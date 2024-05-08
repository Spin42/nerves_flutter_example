defmodule Backend.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :pairword, :string

      timestamps(type: :utc_datetime)
    end
  end
end
