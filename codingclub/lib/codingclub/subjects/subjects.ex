defmodule Codingclub.Subjects do
  @moduledoc """
  The Subjects context.
  """

  import Ecto.Query, warn: false
  alias Codingclub.Repo

  alias Codingclub.Subjects.Schemas.Subject

  def list_subjects do
    Repo.all(Subject)
  end

  def all_subjects() do
    list_subjects
    |> Subject.select_list()
  end

  def get_subject!(id), do: Repo.get!(Subject, id)

  def create_subject(attrs \\ %{}) do
    %Subject{}
    |> Subject.changeset(attrs)
    |> Repo.insert()
  end

  def create_subject!(attrs \\ %{}) do
    %Subject{}
    |> Subject.changeset(attrs)
    |> Repo.insert!()
  end

  def update_subject(%Subject{} = subject, attrs) do
    subject
    |> Subject.changeset(attrs)
    |> Repo.update()
  end

  def delete_subject(%Subject{} = subject) do
    Repo.delete(subject)
  end

  def change_subject(%Subject{} = subject) do
    Subject.changeset(subject, %{})
  end
end
