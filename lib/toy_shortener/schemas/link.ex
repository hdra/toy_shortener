defmodule ToyShortener.Schemas.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :url, :string
    field :alias, :string
    timestamps()
  end

  def changeset(data, params) do
    data
    |> cast(params, [:url, :alias])
    |> validate_required([:url, :alias])
    |> unique_constraint(:alias)
  end
end
