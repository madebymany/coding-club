defmodule Codingclub.Lessons.Schemas.Lesson do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lessons" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(lesson, attrs) do
    lesson
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def select_list(query) do
    query
    |> Enum.map(&{&1.name, &1.id})
  end
end
