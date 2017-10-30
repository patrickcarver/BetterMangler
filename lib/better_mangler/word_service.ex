defmodule BetterMangler.WordService do
    alias Poison
    alias BetterMangler.Conjugater

    def get_random(type, letter) when type in [:adjective, :adverb, :noun, :verb] do
        type 
        |> load_words()
        |> get_words_starting_with_letter(type, String.downcase(letter))
        |> Enum.random()
        |> get_tense_if_verb(type) 
    end

    def get_random(_, _) do
        {:error, "Not a recognized option"}
    end

    defp get_words_starting_with_letter(list, type, letter) when type in [:adjective, :adverb, :noun] do
        Enum.filter(list, fn (word) -> 
            String.starts_with?(word, letter) 
        end)
    end

    defp get_words_starting_with_letter(list, type, letter) when type == :verb do
        Enum.filter(list, fn (map) -> 
            {:ok, word} = Map.fetch(map, "past")
            String.starts_with?(word, letter)
        end)
    end    

    defp get_tense_if_verb(map, type) when type == :verb do
        tense = Enum.random(["past", "present"])

        {:ok, verb} = Map.fetch(map, tense)

        Conjugater.call_random(verb, tense)        
    end

    defp get_tense_if_verb(word, type) when type in [:adjective, :adverb, :noun] do
        word
    end

    defp load_words(type) do
        str = to_string(type) <> "s"

        {:ok, words} =
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