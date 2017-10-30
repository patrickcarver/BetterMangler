defmodule BetterMangler.Conjugater do
    def call(verb, tense) do
        do_call(verb, tense, true)
    end

    def call_random(verb, tense) do
        do_call(verb, tense, third_singular?())
    end

    defp do_call(verb, "present", true) do
        cond do
            ends_in_consonant_and_y?(verb) ->
                change_y_to_i_and_add_es(verb)
            String.ends_with?(verb, ["ch", "o", "sh", "ss", "x"]) ->
                verb <> "es"
            true ->
                verb <> "s"
        end        
    end

    defp do_call(verb, _tense, _third_singular) do
        verb
    end

    defp change_y_to_i_and_add_es(verb) do
        stem = String.replace_suffix(verb, "y", "i")
        stem <> "es"
    end

    defp ends_in_consonant_and_y?(verb) do
        penultimate_consonant?(verb) && String.ends_with?(verb, "y")
    end

    defp penultimate_consonant?(verb) do
        penultimate = String.slice(verb, -2, 1)
        Regex.match?(~r/[b-df-hj-np-tv-z]/, penultimate)
    end

    defp third_singular?() do
        Enum.random(1..3) == 2
    end
end