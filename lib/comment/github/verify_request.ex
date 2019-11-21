defmodule Comment.Github.VerifyRequest do
  @moduledoc """
  This module handle the Plug for Github requests
  """
  import Plug.Conn, only: [get_req_header: 2, read_body: 1]

  alias Comment.Crypto
  alias Comment.{HTTPBadRequest, HTTPNotAuthorized}

  def init(options), do: options

  def call(%Plug.Conn{request_path: path} = conn, opts) do
    if path in opts[:paths], do: verify_request!(conn, opts)
    conn
  end

  defp verify_request!(%Plug.Conn{} = conn, _opts) do
    get_req_header(conn, "x-hub-signature")
    |> case do
      [signature] ->
        verify_signature!(conn, signature)

      _ ->
        raise(HTTPBadRequest)
    end
  end

  defp verify_signature!(conn, signature) do
    digest =
      String.split(signature, "=")
      |> case do
        [_type, digest] ->
          digest

        _ ->
          raise(HTTPBadRequest)
      end

    {:ok, body, _} = read_body(conn)

    result_digest =
      secret_key!()
      |> Crypto.calculate_signature(body)

    unless digest == result_digest, do: raise(HTTPNotAuthorized)
  end

  defp secret_key! do
    Application.fetch_env!(:comment, :github_secret_key)
  end
end
