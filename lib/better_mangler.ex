defmodule BetterMangler do
  defdelegate run(word), to: Mangler
end
