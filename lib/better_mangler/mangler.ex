defmodule BetterMangler.Mangler do
    alias BetterMangler.WordService

    @templates %{
        1 => [
                [ :noun ], 
                [ :verb ], 
                [ :adjective ], 
                [ :adverb ]
             ],
        2 => [
                [ :noun, :verb ], 
                [ :adjective, :noun ], 
                [ :verb, :adjective ]
             ],
        3 => [
                [ :noun, :verb, :adverb ], 
                [ :adjective, :noun, :verb ], 
                [ :noun, :verb, :noun ]
             ],
        4 => [
                [ :adjective, :noun, :verb, :adverb ]
             ],
        5 => [
                [ :adverb, :adjective, :noun, :verb, :noun ]
             ],
        6 => [
                [ :adverb, :adjective, :noun, :verb, :adjective, :noun ]
             ],
        7 => [
                [ :adverb, :adjective, :noun, :adverb, :verb, :adjective, :noun ]
             ],
        8 => [
                [ :adverb, :adjective, :noun, :verb, :adverb, :adjective, :noun ]
             ],
        9 => [
                [ :adverb, :adverb, :adjective, :noun, :noun, :adverb, :adjective, :verb, :adverb ]
             ],
        10 => [
                [ :adverb, :adverb, :adverb, :adjective, :noun, :noun, :adverb, :adjective, :verb, :adverb ] 
              ]
    }

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

        letters = word |> String.codepoints

        process(template, letters, [])
    end

    defp process([template_head | template_tail], [letters_head | letters_tail], list) do
        part_of_speech = template_head
        letter = letters_head

        word = WordService.get_random(part_of_speech, letter)
        new_list = [word | list ]

        process(template_tail, letters_tail, new_list)
    end

    defp process([], [], list) do
        list
        |> Enum.reverse
        |> Enum.join(" ")
    end

    defp get_template(length) do
        { :ok, list } = @templates |> Map.fetch(length)
        list |> Enum.random()
    end

end