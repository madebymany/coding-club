defmodule CodingclubWeb.Views.Helpers.FormatHelpers do
  @moduledoc false
  import Phoenix.HTML.Tag
  import Phoenix.HTML.Form
  import CodingclubWeb.Router.Helpers

  def radio_button_image(form, field, image) do
    content_tag :label, class: "radio-image" do
      [
        radio_button(form, field, image),
        img_tag(static_path(CodingclubWeb.Endpoint, "/images/icons/#{image}.png"))
      ]
    end
  end

  def date(nil), do: ""
  def date(dt), do: Timex.format!(dt, "%d %b", :strftime)

  def datetime(nil), do: ""
  def datetime(dt), do: Timex.format!(dt, "%d %b @ %H:%M", :strftime)

  def time(nil), do: ""
  def time(dt), do: Timex.format!(dt, "%H:%M", :strftime)

  def useful_icon(%{useful: nil}), do: ""
  def useful_icon(%{useful: true}), do: "😍"
  def useful_icon(%{useful: false}), do: "🤨"

  def last_month do
    month = Timex.now() |> Timex.shift([{:months, -1}])
    Timex.format!(month, "%B %Y", :strftime)
  end
end
