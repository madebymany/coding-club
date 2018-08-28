defmodule Codingclub.Repo.Migrations.CreateTerms do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
      timestamps()
    end

    create table(:groups) do
      add :name, :string
      timestamps()
    end

    create table(:lessons) do
      add :name, :string
      timestamps()
    end

    create table(:terms) do
      add :name, :string
      add :example, :text
      add :expanded, :string
      add :notes, :text

      add :group_id, references(:groups, on_delete: :delete_all)
      add :lesson_id, references(:lessons, on_delete: :delete_all)
      add :subject_id, references(:subjects, on_delete: :delete_all)

      timestamps()
    end

  end
end
