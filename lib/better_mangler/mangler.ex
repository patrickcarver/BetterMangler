defmodule BetterMangler.Mangler do
    alias BetterMangler.WordService

	def run(word) do
		word_length = String.length(word)

		cond do
			word_length > 10 ->
				{ :error, "Please, no words/acronyms greater than 10 characters." }
			word_length == 0 ->
				{ :error, "The word/acronym is empty" }
			:true ->
				word |> mangle
		end
	end

	defp mangle(word) do
		template = word |> String.length |> get_template

		word 
		|> String.codepoints
	end

	defp get_template(length) do
		template = %{
			1 => [{ :noun }, { :verb }, { :adjective }, { :adverb }],
			2 => [{ :noun, :verb }, { :adjective, :noun }],
			3 => [{ :noun, :verb, :adverb },{ :adjective, :noun, :verb }, { :noun, :verb, :noun }],
			4 => [{ :adjective, :noun, :verb, :adverb }],
			5 => [],
			6 => [],
			7 => [],
			8 => [],
			9 => [],
			10 => []
		}
	end

end