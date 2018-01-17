defmodule ToyShortener.Schemas.Visit do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToyShortener.Schemas.Link

  schema "visits" do
    field :ip_address, :string
    field :user_agent, :string
    field :referal, :string
    belongs_to :link, Link, on_replace: :nilify
    timestamps(updated_at: false)
  end

  def changeset(data, params) do
    data
    |> cast(params, [:ip_address, :user_agent, :referal])
  end
end
