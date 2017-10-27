defmodule BetterMangler.Mangler do
	alias Poison
	alias BetterMangler.WordService

	def run(word) do
		WordService.get(:adjective)
	end
end