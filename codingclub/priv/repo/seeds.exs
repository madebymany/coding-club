# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Codingclub.Repo.insert!(%Codingclub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Codingclub.{Subjects, Groups, Terms, Lessons}

# subjects
cl_sub = Subjects.get_or_create_subject!(%{name: "Command Line"})
py_sub = Subjects.get_or_create_subject!(%{name: "Python"})

# groups
cl_commands = Groups.get_or_create_group!(%{name: "commands"})
cl_concepts = Groups.get_or_create_group!(%{name: "concepts"})

py_types = Groups.get_or_create_group!(%{name: "types"})
py_functions = Groups.get_or_create_group!(%{name: "functions"})

# lessons

cl_intro = Lessons.get_or_create_lesson!(%{name: "Intro to Command Line"})
py_strings = Lessons.get_or_create_lesson!(%{name: "Strings and Printing"})

# terms
Terms.get_or_create_term!(%{
  name: "cd",
  expanded: "Change Directory",
  example: "cd Documents/my_directory",
  group_id: cl_commands.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "ls",
  expanded: "LiSt",
  example: "ls",
  group_id: cl_commands.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "pwd",
  expanded: "Print Working Directory",
  example: "pwd",
  group_id: cl_commands.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "mv",
  expanded: "MoVe",
  example: "mv myfile.txt new_name.txt",
  group_id: cl_commands.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "cp",
  expanded: "CoPy",
  example: "cp myfile.txt my_new_copy.txt",
  group_id: cl_commands.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "mkdir",
  expanded: "MaKe DIRectory",
  example: "mkdir my_new_directory",
  group_id: cl_commands.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Terminal",
  notes: "A Mac program that gives text based access to the OS",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})
