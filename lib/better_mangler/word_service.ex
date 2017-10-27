defmodule BetterMangler.WordService do
	def load_adjectives() do
		"../../assets/adjectives.json"
		|> Path.expand(__DIR__)
		|> File.read!()
		|> Poison.decode!()
		|> Map.fetch("adjectives")
	end
end