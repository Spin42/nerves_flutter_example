defmodule Backend.Repo.Migrations.RenamePairwordToWordpair do
  use Ecto.Migration

  def change do
    rename table("favorites"), :pairword, to: :wordpair
  end
end
