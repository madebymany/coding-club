defmodule Codingclub.Terms.Schemas.Term do
  use Ecto.Schema
  import Ecto.Changeset

  alias Codingclub.Groups.Schemas.Group
  alias Codingclub.Lessons.Schemas.Lesson
  alias Codingclub.Subjects.Schemas.Subject

  schema "terms" do
    field :example, :string
    field :expanded, :string
    field :name, :string
    field :notes, :string

    belongs_to :group, Group
    belongs_to :lesson, Lesson
    belongs_to :subject, Subject

    timestamps()
  end

  @doc false
  def changeset(term, attrs) do
    term
    |> cast(attrs, [:name, :example, :expanded, :notes, :group_id, :lesson_id, :subject_id])
    |> validate_required([:name, :group_id, :lesson_id, :subject_id])
  end
end
