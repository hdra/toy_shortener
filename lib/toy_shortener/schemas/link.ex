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
    |> validate_required([:url])
    |> unique_constraint(:alias)
    |> validate_url(:url, message: "Invalid URL")
  end

  def validate_url(changeset, field, options \\ []) do
    validate_change(changeset, field, fn(_, url) ->
      case url |> String.to_charlist() |> :http_uri.parse do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || "invalid url: #{inspect(msg)}"}]
      end
    end)
  end
end
