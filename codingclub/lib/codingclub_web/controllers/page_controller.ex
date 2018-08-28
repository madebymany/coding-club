defmodule CodingclubWeb.PageController do
  use CodingclubWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
