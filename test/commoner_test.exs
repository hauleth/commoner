defmodule CommonerTest do
  use ExUnit.Case
  doctest Commoner

  test "greets the world" do
    assert Commoner.hello() == :world
  end
end
