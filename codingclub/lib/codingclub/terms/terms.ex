defmodule Codingclub.Terms do
  @moduledoc """
  The Terms context.
  """

  import Ecto.Query, warn: false
  alias Codingclub.QueryFilter
  alias Codingclub.Repo

  alias Codingclub.Terms.Schemas.Term

  def list_terms do
    Term
    |> Repo.all()
    |> Repo.preload([:lesson, :group, :subject])
  end

  def list_terms_filtered(params, filters, orderables) do
    IO.puts "list_terms_filtered"
    {query, where_clauses} =
      QueryFilter.filter(Term, %Term{}, params, filters, orderables)

    page =
      query
      |> preload([:lesson, :group, :subject])
      |> Repo.paginate(params)

    {page, where_clauses}
  end

  def get_term!(id) do
    Repo.get!(Term, id)
    |> preload([:lesson, :group, :subject])
  end

  def create_term(attrs \\ %{}) do
    %Term{}
    |> Term.changeset(attrs)
    |> Repo.insert()
  end

  def create_term!(attrs \\ %{}) do
    %Term{}
    |> Term.changeset(attrs)
    |> Repo.insert!()
  end

  def update_term(%Term{} = term, attrs) do
    term
    |> Term.changeset(attrs)
    |> Repo.update()
  end

  def delete_term(%Term{} = term) do
    Repo.delete(term)
  end

  def change_term(%Term{} = term) do
    Term.changeset(term, %{})
  end
end
