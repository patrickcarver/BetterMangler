defmodule Mangler do
	def run(word) do
		"../../assets/adjectives.json"
		|> Path.expand(__DIR__)
		|> File.read!()
		
		
	end
end