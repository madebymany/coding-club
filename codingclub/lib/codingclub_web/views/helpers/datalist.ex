defmodule CodingclubWeb.Views.Helpers.Datalist do
  @moduledoc """
  Input helper for datalist input
  """
  import Phoenix.HTML.{Tag, Form}

  def datalist_input(f, field, items, opts \\ []) do
    [
      datalist_tag(f, field, opts),
      datalist_items(f, field, items)
    ]
  end

  defp datalist_items(f, field, items) do
    content_tag :datalist, id: list_id(f, field) do
      Enum.map(items, &tag(:option, value: &1))
    end
  end

  defp datalist_tag(f, field, opts) do
    tag(
      :input,
      [
        type: :list,
        list: list_id(f, field),
        id: input_id(f, field),
        name: input_name(f, field),
        value: input_value(f, field)
      ] ++ opts
    )
  end

  defp list_id(f, field), do: "datalist_#{input_id(f, field)}"
end
