# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Haphx.Repo.insert!(%Haphx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Haphx.Repo
alias Haphx.Exam.Problem

for _ <- 1..50 do
  Repo.insert!(%Problem{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.sentences(%Range{first: 1, last: 2}) |> Enum.join("\n\n"),
  })
end