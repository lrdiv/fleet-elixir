defmodule Fleet.Accounts do

  import Ecto.Query, only: [from: 2], warn: false

  alias Fleet.Repo
  alias Fleet.Accounts.User
  alias Fleet.Accounts.Guardian
  alias Argon2

  def list_users(), do: Repo.all(User)

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user), do: Repo.delete(user)

  def change_user(%User{} = user, attrs \\ %{}), do: User.changeset(user, attrs)

  def authenticate_user(username, plain_text_password) do
    query = from u in User, where: u.username == ^username
    with %User{} = user <- Repo.one(query),
         true <- Argon2.verify_pass(plain_text_password, user.password),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, token, user}
    else
      _err -> {:error, :invalid_credentials}
    end
  end
end
