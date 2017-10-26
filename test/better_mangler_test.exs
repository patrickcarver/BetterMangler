defmodule BetterManglerTest do
  use ExUnit.Case
  doctest BetterMangler

  test "greets the world" do
    assert BetterMangler.hello() == :world
  end
end
