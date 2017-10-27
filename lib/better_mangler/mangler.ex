defmodule BetterMangler.Mangler do
	alias Poison
	alias BetterMangler.WordService

	def run(word) do
		WordService.load_adjectives()
	end
end