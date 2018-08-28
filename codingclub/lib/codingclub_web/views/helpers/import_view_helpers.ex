defmodule CodingclubWeb.ImportViewHelpers do
  @moduledoc false

  @importing "Importing"
  @failed "Failed"
  @completed "Completed"

  def importing?(%{status: @importing}), do: true
  def importing?(_), do: false

  def failed?(%{status: @failed}), do: true
  def failed?(_), do: false

  def completed?(%{status: @completed}), do: true
  def completed?(_), do: false

  def deleted?(%{deleted_at: deleted_at}), do: not is_nil(deleted_at)

  def duration(%{duration: interval}), do: duration(interval)
  def duration(interval) when is_nil(interval), do: "Pending"

  def duration(interval) when is_integer(interval) do
    interval
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end

  def statuses(), do: [@importing, @completed, @failed]
end
