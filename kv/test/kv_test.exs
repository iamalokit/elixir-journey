defmodule KVTest do
  use ExUnit.Case
  doctest KV

  test "greets the world" do
    assert KV.hello() == :world

    # failing the tests intentionally
    # assert KV.hello() == :oops
  end
end
