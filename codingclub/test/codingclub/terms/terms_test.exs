defmodule Codingclub.TermsTest do
  use Codingclub.DataCase

  alias Codingclub.Terms

  describe "terms" do
    alias Codingclub.Terms.Term

    @valid_attrs %{category: "some category", example: "some example", expanded: "some expanded", name: "some name", notes: "some notes"}
    @update_attrs %{category: "some updated category", example: "some updated example", expanded: "some updated expanded", name: "some updated name", notes: "some updated notes"}
    @invalid_attrs %{category: nil, example: nil, expanded: nil, name: nil, notes: nil}

    def term_fixture(attrs \\ %{}) do
      {:ok, term} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Terms.create_term()

      term
    end

    test "list_terms/0 returns all terms" do
      term = term_fixture()
      assert Terms.list_terms() == [term]
    end

    test "get_term!/1 returns the term with given id" do
      term = term_fixture()
      assert Terms.get_term!(term.id) == term
    end

    test "create_term/1 with valid data creates a term" do
      assert {:ok, %Term{} = term} = Terms.create_term(@valid_attrs)
      assert term.category == "some category"
      assert term.example == "some example"
      assert term.expanded == "some expanded"
      assert term.name == "some name"
      assert term.notes == "some notes"
    end

    test "create_term/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Terms.create_term(@invalid_attrs)
    end

    test "update_term/2 with valid data updates the term" do
      term = term_fixture()
      assert {:ok, term} = Terms.update_term(term, @update_attrs)
      assert %Term{} = term
      assert term.category == "some updated category"
      assert term.example == "some updated example"
      assert term.expanded == "some updated expanded"
      assert term.name == "some updated name"
      assert term.notes == "some updated notes"
    end

    test "update_term/2 with invalid data returns error changeset" do
      term = term_fixture()
      assert {:error, %Ecto.Changeset{}} = Terms.update_term(term, @invalid_attrs)
      assert term == Terms.get_term!(term.id)
    end

    test "delete_term/1 deletes the term" do
      term = term_fixture()
      assert {:ok, %Term{}} = Terms.delete_term(term)
      assert_raise Ecto.NoResultsError, fn -> Terms.get_term!(term.id) end
    end

    test "change_term/1 returns a term changeset" do
      term = term_fixture()
      assert %Ecto.Changeset{} = Terms.change_term(term)
    end
  end
end
