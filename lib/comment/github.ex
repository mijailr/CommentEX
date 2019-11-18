defmodule Comment.Github do
  alias Comment.Crypto

  def handle_payload(payload, signature) do
    payload
    |> verify_signature(signature)
  end

  defp verify_signature(payload, signature) do
    [_type, digest] = String.split(signature, "=")
    key = github_config()[:secret_key]

    result_digest = Crypto.calculate_signature(key, payload)

    case result_digest do
      ^digest ->
        {:ok, payload}

      _ ->
        {:error, "not the same digest"}
    end
  end

  defp github_config do
    Application.fetch_env!(:comment, :github)
  end
end
