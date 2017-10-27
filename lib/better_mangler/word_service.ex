defmodule BetterMangler.WordService do
	alias Poison

	def get_random(type) when type in [:adjective, :adverb, :noun, :verb] do
		type |> load_words() |> Enum.random() 
	end

	def get_random(_) do
		{ :error, "Not a recognized option" }
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