defmodule Codingclub.Groups.Schemas.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Codingclub.Groups.Schemas.Group

  schema "groups" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def select_list(query) do
    query
    |> Enum.map(&{&1.name, &1.id})
  end
end
