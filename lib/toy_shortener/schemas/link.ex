defmodule ToyShortener.Schemas.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToyShortener.Schemas.Visit

  schema "links" do
    field :url, :string
    field :alias, :string
    has_many :visits, Visit, on_delete: :delete_all
    timestamps()
  end

  def changeset(data, params) do
    data
    |> cast(params, [:url, :alias])
    |> validate_required([:url, :alias])
    |> unique_constraint(:alias)
  end
end
