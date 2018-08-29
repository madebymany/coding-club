defmodule CodingclubWeb.TermControllerTest do
  use CodingclubWeb.ConnCase

  alias Codingclub.Terms

  @create_attrs %{
    category: "some category",
    example: "some example",
    expanded: "some expanded",
    name: "some name",
    notes: "some notes"
  }
  @update_attrs %{
    category: "some updated category",
    example: "some updated example",
    expanded: "some updated expanded",
    name: "some updated name",
    notes: "some updated notes"
  }
  @invalid_attrs %{category: nil, example: nil, expanded: nil, name: nil, notes: nil}

  def fixture(:term) do
    {:ok, term} = Terms.create_term(@create_attrs)
    term
  end

  describe "index" do
    test "lists all terms", %{conn: conn} do
      conn = get conn, term_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Terms"
    end
  end

  describe "new term" do
    test "renders form", %{conn: conn} do
      conn = get conn, term_path(conn, :new)
      assert html_response(conn, 200) =~ "New Term"
    end
  end

  describe "create term" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, term_path(conn, :create), term: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == term_path(conn, :show, id)

      conn = get conn, term_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Term"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, term_path(conn, :create), term: @invalid_attrs
      assert html_response(conn, 200) =~ "New Term"
    end
  end

  describe "edit term" do
    setup [:create_term]

    test "renders form for editing chosen term", %{conn: conn, term: term} do
      conn = get conn, term_path(conn, :edit, term)
      assert html_response(conn, 200) =~ "Edit Term"
    end
  end

  describe "update term" do
    setup [:create_term]

    test "redirects when data is valid", %{conn: conn, term: term} do
      conn = put(conn, term_path(conn, :update, term), term: @update_attrs)
      assert redirected_to(conn) == term_path(conn, :show, term)

      conn = get conn, term_path(conn, :show, term)
      assert html_response(conn, 200) =~ "some updated category"
    end

    test "renders errors when data is invalid", %{conn: conn, term: term} do
      conn = put(conn, term_path(conn, :update, term), term: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Term"
    end
  end

  describe "delete term" do
    setup [:create_term]

    test "deletes chosen term", %{conn: conn, term: term} do
      conn = delete conn, term_path(conn, :delete, term)
      assert redirected_to(conn) == term_path(conn, :index)

      assert_error_sent(404, fn ->
        get conn, term_path(conn, :show, term)
      end)
    end
  end

  defp create_term(_) do
    term = fixture(:term)
    {:ok, term: term}
  end
end
