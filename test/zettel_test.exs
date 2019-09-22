defmodule ZettelTest do
  use ExUnit.Case
  doctest Zettel

  test "greets the world" do
    assert Zettel.hello() == :world
  end
end
