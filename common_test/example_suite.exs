defmodule Commoner.ExampleSuite do
  use CommonTest.Suite

  test "foo bar" do
    assert (1 + 1) in [2]
  end

  test "bar baz" do
    CommonTest.log("Hello")
  end
end
