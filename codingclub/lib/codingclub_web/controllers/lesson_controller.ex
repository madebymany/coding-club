defmodule CodingclubWeb.LessonController do
  use CodingclubWeb, :controller

  alias Codingclub.Lessons
  alias Codingclub.Lessons.Schemas.Lesson

  def index(conn, _params) do
    lessons = Lessons.list_lessons()
    render(conn, "index.html", lessons: lessons)
  end

  def new(conn, _params) do
    changeset = Lessons.change_lesson(%Lesson{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lesson" => lesson_params}) do
    case Lessons.create_lesson(lesson_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Lesson created successfully.")
        |> redirect(to: lesson_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lesson = Lessons.get_lesson!(id)
    render(conn, "show.html", lesson: lesson)
  end

  def edit(conn, %{"id" => id}) do
    lesson = Lessons.get_lesson!(id)
    changeset = Lessons.change_lesson(lesson)
    render(conn, "edit.html", lesson: lesson, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lesson" => lesson_params}) do
    lesson = Lessons.get_lesson!(id)

    case Lessons.update_lesson(lesson, lesson_params) do
      {:ok, lesson} ->
        conn
        |> put_flash(:info, "Lesson updated successfully.")
        |> redirect(to: lesson_path(conn, :show, lesson))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lesson: lesson, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lesson = Lessons.get_lesson!(id)
    {:ok, _lesson} = Lessons.delete_lesson(lesson)

    conn
    |> put_flash(:info, "Lesson deleted successfully.")
    |> redirect(to: lesson_path(conn, :index))
  end
end
