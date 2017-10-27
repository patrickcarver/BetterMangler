defmodule BetterMangler.WordService do

	def get_random(:adverb) do
		
	end

	def get_random(:noun) do
		
	end

	def get_random(:verb) do
		
	end

	def get_random(:adjective) do
		load_adjectives() |> Enum.random()
	end

	def get_random(_) do
		{:error, "Not a recognized option"}
	end

	def load_nouns() do
		
	end

	def load_adjectives() do
		{ :ok, adjectives } = 
			"../../assets/adjectives.json"
			|> Path.expand(__DIR__)
			|> File.read!()
			|> Poison.decode!()
			|> Map.fetch("adjectives")

		adjectives
	end

	defp load_and_parse(file) do
		
	end
end