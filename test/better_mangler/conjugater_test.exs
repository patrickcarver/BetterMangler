defmodule BetterMangler.ConjugaterTest do
  use ExUnit.Case
  
  alias BetterMangler.Conjugater
  
  doctest Conjugater

  test "'launch' is conjugated as 'launches'" do
    assert Conjugater.call("launch", "present", :singular) == ["launches", :singular]
  end

  test "'go' is conjugated as 'goes'" do
    assert Conjugater.call("go", "present", :singular) == ["goes", :singular]
  end

  test "'go' is conjugated as 'go'" do
    assert Conjugater.call("go", "present", :plural) == ["go", :plural]
  end  

  test "'hush' is conjugated as 'hushes'" do
      assert Conjugater.call("hush", "present", :singular) == ["hushes", :singular]
  end

  test "'obsess' is conjugated as 'obsesses'" do
      assert Conjugater.call("obsess", "present", :singular) == ["obsesses", :singular]
  end

  test "'obsess' is conjugated as 'obsess'" do
      assert Conjugater.call("obsess", "present", :plural) == ["obsess", :plural]
  end

  test "'jump' is conjugated as 'jumps'" do
      assert Conjugater.call("jump", "present", :singular) == ["jumps", :singular]
  end
end