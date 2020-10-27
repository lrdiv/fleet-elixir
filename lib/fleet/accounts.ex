defmodule Fleet.Accounts do

  import Ecto.Query, only: [from: 2], warn: false

  alias Fleet.Repo
  alias Fleet.Accounts.User
  alias Fleet.Accounts.Guardian
  alias Argon2

  def list_users, do: Repo.all(User)

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
    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}
      user -> login_user(plain_text_password, user)
    end
  end

  defp login_user(password, user) do
    case Argon2.verify_pass(password, user.password) do
      true -> generate_token(user)
      false -> {:error, :invalid_credentials}
    end
  end

  defp generate_token(user) do
    case Guardian.encode_and_sign(user) do
      {:ok, token, _claims} -> {:ok, token, user}
      err -> {:error, err}
    end
  end
end
