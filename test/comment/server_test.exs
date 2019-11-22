defmodule Comment.ServerTest do
  use ExUnit.Case, async: true
  use Comment.RepoCase
  use Plug.Test

  alias Comment.{Server}

  @opts Server.init([])

  test "Github webhook installation create" do
    body = File.read!("test/fixtures/webhook/github.installation.create.json")
    params = Jason.decode!(body)

    conn =
      conn(:post, "/webhook/github", params)
      |> put_req_header("x-hub-signature", "sha1=0b586799339e68bacb2f3bfd51e1b341ef04aa36")
      |> put_req_header("x-github-event", "installation")
      |> Plug.Conn.assign(:raw_body, body)

    conn = Server.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end
end
