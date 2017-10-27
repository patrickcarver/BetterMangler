defmodule Mangler do
	alias Poison

	def run(word) do
		"../../assets/adjectives.json"
		|> Path.expand(__DIR__)
		|> File.read!()
		|> Poison.decode!()
		|> Map.fetch("adjectives")
	end
end