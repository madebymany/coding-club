defmodule Codingclub.Lessons do
  @moduledoc """
  The Lessons context.
  """

  import Ecto.Query, warn: false
  alias Codingclub.Repo

  alias Codingclub.Lessons.Schemas.Lesson

  def list_lessons do
    Repo.all(Lesson)
  end

  def all_lessons() do
    list_lessons
    |> Lesson.select_list()
  end

  def get_lesson!(id), do: Repo.get!(Lesson, id)

  def get_lesson(attrs \\ %{}) do
    Repo.get_by(Lesson, attrs)
  end

  def create_lesson(attrs \\ %{}) do
    %Lesson{}
    |> Lesson.changeset(attrs)
    |> Repo.insert()
  end

  def create_lesson!(attrs \\ %{}) do
    %Lesson{}
    |> Lesson.changeset(attrs)
    |> Repo.insert!()
  end

  def get_or_create_lesson!(attrs \\ {}) do
    if lesson = get_lesson(attrs) do
      lesson
    else
      create_lesson!(attrs)
    end
  end

  def update_lesson(%Lesson{} = lesson, attrs) do
    lesson
    |> Lesson.changeset(attrs)
    |> Repo.update()
  end

  def delete_lesson(%Lesson{} = lesson) do
    Repo.delete(lesson)
  end

  def change_lesson(%Lesson{} = lesson) do
    Lesson.changeset(lesson, %{})
  end
end
