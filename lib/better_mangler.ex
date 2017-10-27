defmodule BetterMangler do
    defdelegate run(word), to: BetterMangler.Mangler
end
