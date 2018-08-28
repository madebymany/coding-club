defmodule CodingclubWeb.TermController do
  use CodingclubWeb, :controller

  alias Codingclub.Terms
  alias Codingclub.Terms.Schemas.Term
  alias Codingclub.{Lessons, Groups, Subjects}

  @filters [:name, :group_id, :lesson_id]
  @orderables [:name, :expanded]

  defp all_lessons(), do: Lessons.all_lessons()
  defp all_groups(), do: Groups.all_groups()
  defp all_subjects(), do: Subjects.all_subjects()

  def index(conn, params) do
    {page, filter_params} = Terms.list_terms_filtered(params, @filters, @orderables)
    render(
      conn,
      "index.html",
      page: page,
      filter_params: filter_params,
      all_lessons: all_lessons(),
      all_groups: all_groups(),
      all_subjects: all_subjects()
    )
  end

  def new(conn, _params) do
    changeset = Terms.change_term(%Term{})
    render(
      conn,
      "new.html",
      changeset: changeset,
      all_lessons: all_lessons(),
      all_groups: all_groups(),
      all_subjects: all_subjects()
    )
  end

  def create(conn, %{"term" => term_params}) do
    case Terms.create_term(term_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Term created successfully.")
        |> redirect(to: term_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(
          conn,
          "new.html",
          changeset: changeset,
          all_lessons: all_lessons(),
          all_groups: all_groups(),
          all_subjects: all_subjects()
        )
    end
  end

  def show(conn, %{"id" => id}) do
    term = Terms.get_term!(id)
    render(conn, "show.html", term: term)
  end

  def edit(conn, %{"id" => id}) do
    term = Terms.get_term!(id)
    changeset = Terms.change_term(term)
    render(
      conn,
      "edit.html",
      term: term,
      changeset: changeset,
      all_lessons: all_lessons(),
      all_groups: all_groups(),
      all_subjects: all_subjects()
    )
  end

  def update(conn, %{"id" => id, "term" => term_params}) do
    term = Terms.get_term!(id)

    case Terms.update_term(term, term_params) do
      {:ok, term} ->
        conn
        |> put_flash(:info, "Term updated successfully.")
        |> redirect(to: term_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(
          conn,
          "edit.html",
          term: term,
          changeset: changeset,
          all_lessons: all_lessons(),
          all_groups: all_groups(),
          all_subjects: all_subjects()
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    term = Terms.get_term!(id)
    {:ok, _term} = Terms.delete_term(term)

    conn
    |> put_flash(:info, "Term deleted successfully.")
    |> redirect(to: term_path(conn, :index))
  end
end
