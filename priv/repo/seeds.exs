# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fleet.Repo.insert!(%Fleet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

%{username: "lawrence@lrdiv.co", password: "helloworld"}
  |> Fleet.Accounts.create_user()
