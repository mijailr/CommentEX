defmodule Comment.CryptoTest do
  use ExUnit.Case
  import Comment.Crypto

  alias Comment.Crypto

  doctest Crypto

  @key "dummysecret"
  @payload File.read!("test/fixtures/webhook/github.installation.create.json")
  @signature "e5a76829031075771f2a99b8e87402302508d148"

  test "calculate_signature/2" do
    assert calculate_signature(@key, @payload) == @signature
  end
end
