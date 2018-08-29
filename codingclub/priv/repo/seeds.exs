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

Terms.get_or_create_term!(%{
  name: "Unix",
  notes: "a family of operating systems that includes MacOS. Terminal comes with a Unix shell, Bash",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Shell",
  notes: "A shell is a program that lets you type commands. Terminal comes with a Unix shell, Bash",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Bash",
  notes: "The default unix shell in Terminal. Bash is also the name of the programming language that you can run in the shell.",
  expanded: "Bourne Again SHell",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Prompt",
  notes: "The text displayed in a shell at the start of each line. It is customisable and can include information about your computer.",
  example: "Katherines-MacBook-Pro:exercises kat$",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Prompt",
  notes: "The text displayed in a shell at the start of each line. It is customisable and can include information about your computer.",
  example: "Katherines-MacBook-Pro:exercises kat$",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Command",
  notes: "A program you can run in Bash by typing its name and pressing enter. Some commands take arguments and flags",
  example: """
  $ ls -l cat_literature/novellas
  drwxr-xr-x  1632 kat  staff   52224 28 Nov  2017 archives
  -rw-r--r--     1 kat  staff     343 24 Mar  2017 Animated Kitty Adventures.pdf
  -rw-r--r--     1 kat  staff     239 14 Sep  2017 cat_and_mat.txt
  -rw-r--r--@    1 kat  staff       5 17 Aug 18:55 cat_goes_to_the_seaside.txt
  -rw-r--r--     1 kat  staff     730 24 Mar  2017 cats_in_hats.txt
  """,
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})

Terms.get_or_create_term!(%{
  name: "Argument",
  notes: "A program you can run in Bash by typing its name and pressing enter. Some commands take arguments and flags",
  group_id: cl_concepts.id,
  lesson_id: cl_intro.id,
  subject_id: cl_sub.id
})
