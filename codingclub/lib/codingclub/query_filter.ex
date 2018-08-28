defmodule Codingclub.QueryFilter do
  @moduledoc """
  Use Ecto changeset to cast and validate conditional paramters to run in a query
  """
  import Ecto.Query

  def filter(query, struct, params, filters, orderables \\ [:inserted_at]) do
    IO.inspect params
    params = make_atoms(params) |> IO.inspect
    fields_to_filter_by = flatten_filter_fields(filters) |> IO.inspect
    casted_params = cast_filter_params(struct, params, fields_to_filter_by) |> IO.inspect

    query =
      query
      |> make_where_clauses(casted_params, filters)
      |> get_order_by_query(params, orderables)
      |> IO.inspect

    filter_params =
      casted_params
      |> add_page_param(params)
      |> add_order_by_params(params, orderables)
      |> IO.inspect

    {query, filter_params}
  end

  def cast_filter_params(struct, params, fields_to_filter_by) do
    # Using changeset to cast query parameters into a list of where clauses.
    # When a field has a defualt value a null value in params will be
    # set by changeset to that default value.
    # This is intended for creates and updates, but those values
    # should be removed from the where clause.
    struct
    |> Ecto.Changeset.cast(params, fields_to_filter_by, empty_values: [nil])
    |> IO.inspect
    |> Map.fetch!(:changes)
    |> Map.to_list()
    |> Enum.reject(&has_empty_value?(&1))
  end

  def flatten_filter_fields(filters) do
    filters
    |> Enum.map(fn
      k when is_atom(k) -> k
      {k, _v} -> k
    end)
  end

  defp make_where_clauses(query, casted_params, filters) do
    filters
    |> Enum.filter(fn
      k when is_atom(k) -> Keyword.has_key?(casted_params, k)
      {k, _v} -> Keyword.has_key?(casted_params, k)
    end)
    |> Enum.reduce(query, &make_clause(&1, &2, casted_params))
  end

  defp make_clause(key, query, casted_params) when is_atom(key) do
    val = Keyword.get(casted_params, key)
    where(query, [u], field(u, ^key) == ^val)
  end

  defp make_clause({:to, :lt}, query, casted_params) do
    val = Keyword.get(casted_params, :to)
    where(query, [u], field(u, :inserted_at) < ^val)
  end

  defp make_clause({:since, :gt}, query, casted_params) do
    val = Keyword.get(casted_params, :since)
    where(query, [u], field(u, :inserted_at) > ^val)
  end

  defp make_clause({key, :text}, query, casted_params) do
    val = Keyword.get(casted_params, key)
    val = "%#{val}%"
    where(query, [u], ilike(field(u, ^key), ^val))
  end

  defp make_clause({key, :gt}, query, casted_params) do
    val = Keyword.get(casted_params, key)
    where(query, [u], field(u, ^key) > ^val)
  end

  defp get_order_by_query(query, params, orderables) do
    case get_order_by(params, orderables) do
      {direction, sort} ->
        order_by(query, [e], [{^direction, field(e, ^sort)}])

      _ ->
        order_by(query, desc: :inserted_at)
    end
  end

  defp get_order_by(params, orderables) do
    with {direction, sort} <- get_order_by_params(params),
         true <- Enum.member?(orderables, sort) do
      {direction, sort}
    else
      _ -> nil
    end
  end

  defp get_order_by_params(params) do
    case params do
      %{direction: direction, sort: sort} ->
        {String.to_atom(direction), String.to_atom(sort)}

      %{direction: direction} ->
        {String.to_atom(direction), :inserted_at}

      %{sort: sort} ->
        {:desc, String.to_atom(sort)}

      _ ->
        nil
    end
  end

  defp add_order_by_params(where_clauses, params, orderables) do
    case get_order_by(params, orderables) do
      {direction, sort} ->
        where_clauses
        |> Keyword.put_new(:direction, direction)
        |> Keyword.put_new(:sort, sort)

      _ ->
        where_clauses
    end
  end

  defp add_page_param(where_clauses, params) do
    if Map.has_key?(params, :page) do
      Keyword.put_new(where_clauses, :page, Map.get(params, :page))
    else
      where_clauses
    end
  end

  defp has_empty_value?({_key, ""}), do: true
  defp has_empty_value?({_key, _value}), do: false
  defp string_key({k, v}) when is_binary(k), do: {String.to_atom(k), v}
  defp string_key({k, v}) when is_atom(k), do: {k, v}
  defp make_atoms(params), do: Map.new(params, &string_key/1)
end
