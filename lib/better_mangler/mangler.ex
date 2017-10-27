defmodule BetterMangler.Mangler do
	alias BetterMangler.WordService

	def run(word) do
		WordService.get_random(:adjective)
	end
end