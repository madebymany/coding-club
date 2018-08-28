defmodule Codingclub.Subjects.Schemas.Subject do
  use Ecto.Schema
  import Ecto.Changeset


  schema "subjects" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def select_list(query) do
    query
    |> Enum.map(&{&1.name, &1.id})
  end
end
