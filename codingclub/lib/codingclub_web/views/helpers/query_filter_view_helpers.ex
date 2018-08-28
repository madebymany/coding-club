defmodule CodingclubWeb.Views.Helpers.QueryFilterViewHelpers do
  @moduledoc false

  import Scrivener.HTML
  use Phoenix.HTML

  def pagination_links_with_filters(conn, page, path, filter_params) do
    # Remove persisted page param, as these links will be changing it
    filter_params = filter_params |> Keyword.delete(:page)
    pagination_links(conn, page, Keyword.merge([path: path], filter_params))
  end

  def toggle_sort(filter_params, field) do
    case get_direction(filter_params) do
      :desc ->
        Keyword.merge(filter_params, sort: field, direction: :asc)

      :asc ->
        Keyword.drop(filter_params, [:sort, :direction])

      _ ->
        Keyword.merge(filter_params, sort: field, direction: :desc)
    end
  end

  def get_direction(filter_params) do
    if Keyword.has_key?(filter_params, :direction) do
      filter_params
      |> Keyword.get(:direction)
    end
  end

  def get_sort(filter_params) do
    if Keyword.has_key?(filter_params, :sort) do
      filter_params
      |> Keyword.get(:sort)
    end
  end

  def get_arrow(filter_params) do
    case get_direction(filter_params) do
      :desc -> "↓"
      :asc -> "↑"
      _ -> ""
    end
  end

  def sort_link(conn, field, filter_params, path) do
    label =
      field
      |> Atom.to_string()
      |> String.capitalize()
      |> String.replace("_", " ")

    sort_link(conn, field, filter_params, path, label)
  end

  def sort_link(conn, field, filter_params, path, label) when is_binary(label) do
    arrow =
      case get_sort(filter_params) do
        ^field -> get_arrow(filter_params)
        _ -> ""
      end

    link("#{label} #{arrow}", to: path.(conn, :index, toggle_sort(filter_params, field)))
  end
end
