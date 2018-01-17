defmodule ToyShortener.Repo.Migrations.CreateLinksTable do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :alias, :string
      timestamps()
    end
    create unique_index(:links, [:alias])
  end
end
