defmodule Comment.ServerTest do
  use ExUnit.Case, async: true
  use Comment.RepoCase
  use Plug.Test

  alias Comment.{Server}

  @opts Server.init([])

  test "not found" do
    conn =
      conn(:post, "/random")
      |> Server.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end

  test "bad request" do
    conn =
      conn(:post, "/webhook/github", "")
      |> put_req_header("content-type", "application/json")

    assert_raise Comment.HTTPBadRequest, fn ->
      Server.call(conn, @opts)
    end

    assert {400, _, _} = sent_resp(conn)
  end

  test "bad request signature" do
    conn =
      conn(:post, "/webhook/github", "")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-hub-signature", "sha1")

    assert_raise Comment.HTTPBadRequest, fn ->
      Server.call(conn, @opts)
    end

    assert {400, _, _} = sent_resp(conn)
  end

  test "not authorized" do
    conn =
      conn(:post, "/webhook/github", "")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-hub-signature", "sha1=#")

    assert_raise Comment.HTTPNotAuthorized, fn ->
      Server.call(conn, @opts)
    end

    assert {401, _, _} = sent_resp(conn)
  end

  test "Github webhook installation create" do
    conn = github_request("installation", "create")

    assert conn.state == :sent
    assert conn.status == 200
  end

  defp connection(event, body, signature) do
    conn(:post, "/webhook/github", body)
    |> put_req_header("content-type", "application/json")
    |> put_req_header("x-hub-signature", "sha1=#{signature}")
    |> put_req_header("x-github-event", event)
    |> Server.call(@opts)
  end

  defp github_request(event, action) do
    fixture = "test/fixtures/webhook/github.#{event}.#{action}.json"
    body = File.read!(fixture)
    signature = File.read!("#{fixture}.sig") |> String.replace("\n", "")
    connection(event, body, signature)
  end
end
