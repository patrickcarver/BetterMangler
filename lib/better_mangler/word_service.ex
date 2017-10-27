defmodule BetterMangler.WordService do
	alias Poison

    def get_random(type) when type in [:adjective, :adverb, :noun, :verb] do
		type 
		|> load_words() 
		|> Enum.random()
		|> get_tense_if_verb(type) 
	end

	def get_random(_) do
		{ :error, "Not a recognized option" }
	end

	defp get_tense_if_verb(map, type) when type == :verb do
		tense = ["past", "present"] |> Enum.random()
		{ :ok, verb } = map |> Map.fetch(tense)
		verb		
	end

	defp get_tense_if_verb(word, type) when type in [:adjective, :adverb, :noun] do
		word
	end

	defp load_words(type) do
		str = to_string(type) <> "s"

		{ :ok, words } =
			"../../assets/#{str}.json"
			|> load_and_parse
			|> Map.fetch(str)

		words
	end

	defp load_and_parse(file) do
		file
		|> Path.expand(__DIR__)
		|> File.read!()
		|> Poison.decode!()
	end
end