defmodule Comment.Github do
  @moduledoc """
  This module handle the Github actions for installations
  and pull requests.
  """
  alias Comment.Crypto
  alias Comment.Github.{Tokens}

  def handle_payload(payload, signature) do
    payload
    |> verify_signature(signature)
    |> json_payload()
    |> authenticate_instalation()
  end

  @doc """
  Verify the signature of a payload

  # Example
  iex> Comment.Github.verify_signature("random payload", "sha1=6f4aeff3af1d7c052a99a47917f478c5b88ed5c5")
  {:ok, "random payload"}
  iex> Comment.Github.verify_signature("bad signature", "sha1=55b037a2f2380af2a4283a9cc1b245b74854eab5")
  {:error, "not the same digest"}
  """

  @spec verify_signature(binary, binary) :: {:ok, binary} | {:error, binary}
  def verify_signature(payload, signature) do
    [_type, digest] = String.split(signature, "=")

    result_digest =
      secret_key()
      |> Crypto.calculate_signature(payload)

    case result_digest do
      ^digest ->
        {:ok, payload}

      _ ->
        {:error, "not the same digest"}
    end
  end

  defp json_payload({:ok, payload}) do
    Jason.decode!(payload)
  end

  defp authenticate_instalation(payload) do
    instalation_id = payload["installation"]["id"]
    token = Tokens.generate_and_sign!()

    client =
      Tentacat.Client.new(%{jwt: token})
      |> Tentacat.App.Installations.token(instalation_id)

    {:ok, client, payload}
  end

  defp secret_key do
    Application.fetch_env!(:comment, :github_secret_key)
  end
end
