defmodule CodingclubWeb.SubjectController do
  use CodingclubWeb, :controller

  alias Codingclub.Subjects
  alias Codingclub.Subjects.Schemas.Subject

  def index(conn, _params) do
    subjects = Subjects.list_subjects()
    render(conn, "index.html", subjects: subjects)
  end

  def new(conn, _params) do
    changeset = Subjects.change_subject(%Subject{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subject" => subject_params}) do
    case Subjects.create_subject(subject_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Subject created successfully.")
        |> redirect(to: subject_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = Subjects.get_subject!(id)
    render(conn, "show.html", subject: subject)
  end

  def edit(conn, %{"id" => id}) do
    subject = Subjects.get_subject!(id)
    changeset = Subjects.change_subject(subject)
    render(conn, "edit.html", subject: subject, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Subjects.get_subject!(id)

    case Subjects.update_subject(subject, subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject updated successfully.")
        |> redirect(to: subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subject: subject, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = Subjects.get_subject!(id)
    {:ok, _subject} = Subjects.delete_subject(subject)

    conn
    |> put_flash(:info, "Subject deleted successfully.")
    |> redirect(to: subject_path(conn, :index))
  end
end
