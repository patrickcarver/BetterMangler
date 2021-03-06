defmodule BetterMangler.Mangler do
    alias BetterMangler.{WordService, Templates}
    alias Inflex

    def run(word) do
        word_length = String.length(word)

        cond do
            word_length > 10 ->
                {:error, "Please, no words/acronyms greater than 10 characters."}
            word_length == 0 ->
                {:error, "The word/acronym is empty"}
            true ->
                mangle(word)
        end
    end

    defp mangle(word) do
        template = word |> String.length |> Templates.get_random_template_by_length
        letters = String.codepoints(word)

        process([], template, letters)
    end

    defp process(list, [template_head | template_tail], [letters_head | letters_tail]) do   
        word = WordService.get_random(template_head, letters_head)
        data = List.flatten([template_head, word])

        process([data | list], template_tail, letters_tail)
    end

    defp process(list, [], []) do        
        word_list = Enum.reverse(list)
        verb_info = find_verb_number(word_list)
        
        sentence_list = set_number_for_noun(word_list, verb_info)

        create_sentence(sentence_list)
    end

    defp create_sentence(sentence_list) do
        Enum.reduce(sentence_list, "", fn(item, acc) -> 
            word = item |> Enum.at(1) |> String.capitalize
            acc <> word <> " "
        end) |> String.trim        
    end

    defp set_number_for_noun(list, {nil, 0}) do
        list
    end

    defp set_number_for_noun(list, {number, index}) do
        info = Enum.at(list, index)
        type = Enum.at(info, 0)

        if index == -1 do
            list
        else
            if type == :noun do
                word = Enum.at(info, 1)
                method = String.to_atom(to_string(number) <> "ize")
                noun = apply(Inflex, method, [word])
                List.replace_at(list, index, [type, noun])
            else
                set_number_for_noun(list, {number, (index - 1)})
            end
        end        
    end

    defp find_verb_number(list) do
        verb = Enum.find(list, &verb?/1)
                 
        if verb == nil do
            { nil, 0 }
        else
            number = Enum.at(verb, 2)
            index = Enum.find_index(list, &verb?/1) - 1

            {number, index}
        end     
    end

    defp verb?(item) do
        Enum.at(item, 0) == :verb
    end
end