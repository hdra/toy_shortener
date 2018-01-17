defmodule ToyShortener.Repo.Migrations.CreateVisitsTable do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :link_id, references(:links, column: :id, on_delete: :delete_all)
      add :ip_address, :string
      add :user_agent, :string
      add :referal, :string
      timestamps(updated_at: false)
    end
  end
end
