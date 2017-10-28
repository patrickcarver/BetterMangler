defmodule BetterMangler.Mangler do
    alias BetterMangler.WordService

    @templates %{
        1 => [
                [:noun], 
                [:verb], 
                [:adjective], 
                [:adverb]
             ],
        2 => [
                [:noun, :verb], 
                [:adjective, :noun], 
                [:verb, :adjective],
                [:noun, :noun]
             ],
        3 => [
                [:noun, :verb, :adverb], 
                [:adjective, :noun, :verb], 
                [:noun, :verb, :noun],
                [:noun, :noun, :noun]
             ],
        4 => [
                [:adjective, :noun, :verb, :adverb],
                [:noun, :noun, :noun, :noun]
             ],
        5 => [
                [:adverb, :adjective, :noun, :verb, :noun],
                [:noun, :noun, :noun, :noun, :noun]
             ],
        6 => [
                [:adverb, :adjective, :noun, :verb, :adjective, :noun]
             ],
        7 => [
                [:adverb, :adjective, :noun, :adverb, :verb, :adjective, :noun]
             ],
        8 => [
                [:adverb, :adjective, :noun, :verb, :adverb, :adjective, :noun]
             ],
        9 => [
                [:adverb, :adverb, :adjective, :noun, :noun, :adverb, :adjective, :verb, :adverb]
             ],
        10 => [
                [:adverb, :adverb, :adverb, :adjective, :noun, :noun, :adverb, :adjective, :verb, :adverb] 
              ]
    }

    def run(word) do
        word_length = String.length(word)

        cond do
            word_length > 10 ->
                {:error, "Please, no words/acronyms greater than 10 characters."}
            word_length == 0 ->
                {:error, "The word/acronym is empty"}
            :true ->
                mangle(word)
        end
    end

    defp mangle(word) do
        template = word |> String.length |> get_template
        letters = String.codepoints(word)

        process([], template, letters)
    end

    defp process(list, [template_head | template_tail], [letters_head | letters_tail]) do
        word = WordService.get_random(template_head, letters_head)
        
        process([word | list], template_tail, letters_tail)
    end

    defp process(list, [], []) do
        list
        |> Enum.reverse
        |> Enum.join(" ")
    end

    defp get_template(length) do
        {:ok, list} = Map.fetch(@templates, length)
        Enum.random(list)
    end

end