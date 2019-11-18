defmodule Comment.CryptoTest do
  use ExUnit.Case
  import Comment.Crypto

  alias Comment.Crypto

  doctest Crypto

  @key "cbbdd7ee6675f43529a399cfb5f4e3249b8e9285"
  @payload "String to be signed"
  @signature "129e8ca6a6b279b1065f86b8e9cec6ae7f555372"

  test "calculate_signature/2" do
    assert calculate_signature(@key, @payload) == @signature
  end
end
