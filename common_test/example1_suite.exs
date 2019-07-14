defmodule Commoner.Example1Suite do
  use CommonTest.Suite

  test "foo bar" do
    assert 2 = 1 + 1
  end

  test "bar baz" do
    CommonTest.log("Hello")
  end
end
