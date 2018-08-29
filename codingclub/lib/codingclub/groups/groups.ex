defmodule Codingclub.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias Codingclub.Repo

  alias Codingclub.Groups.Schemas.Group

  def list_groups do
    Repo.all(Group)
  end

  def all_groups() do
    list_groups
    |> Group.select_list()
  end

  def get_group!(id), do: Repo.get!(Group, id)

  def get_group(attrs \\ %{}) do
    Repo.get_by(Group, attrs)
  end

  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def create_group!(attrs \\ %{}) do
    IO.puts "create_group!"
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert!()
  end

  def get_or_create_group!(attrs \\ {}) do
    if group = get_group(attrs) do
      group
    else
      create_group!(attrs)
    end
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end
end
