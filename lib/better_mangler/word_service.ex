defmodule BetterMangler.WordService do
    alias Poison

    def get_random(type, letter) when type in [:adjective, :adverb, :noun] do
        type 
        |> load_words()
        |> get_words_starting_with_letter(String.downcase(letter))
        |> Enum.random()
        |> get_tense_if_verb(type) 
    end

    def get_random(type, letter) when type == :verb do
        type
        |> load_words()
        |> get_verbs_starting_with_letter(String.downcase(letter))
        |> Enum.random()
        |> get_tense_if_verb(type)
    end

    def get_random(_, _) do
        { :error, "Not a recognized option" }
    end

    defp get_verbs_starting_with_letter(list, letter) do
        list |> Enum.filter(fn (map) -> 
            { :ok, word } = Map.fetch(map, "past")
            String.starts_with?(word, letter)
        end)
    end

    defp get_words_starting_with_letter(list, letter) do
        list |> Enum.filter(fn (word) -> word |> String.starts_with?(letter) end)
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