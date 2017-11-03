defmodule BetterMangler.Conjugater do
    def call_random(verb, tense) do
        call(verb, tense, random_number())
    end

    def call(verb, "present", :singular) do
        [get_conjugation(verb), :singular]        
    end

    def call(verb, "present", :plural) do
        [verb, :plural]
    end

    def call(verb, "past", number) do
        [verb, number]
    end

    defp get_conjugation(verb) do
        cond do
            ends_in_consonant_and_y?(verb) ->
                change_y_to_i_and_add_es(verb)
            needs_es?(verb) ->
                verb <> "es"
            true ->
                verb <> "s"
        end        
    end

    defp change_y_to_i_and_add_es(verb) do
        stem = String.replace_suffix(verb, "y", "i")
        stem <> "es"
    end

    defp needs_es?(verb) do
        String.ends_with?(verb, ["ch", "o", "sh", "ss", "x"])
    end

    defp ends_in_consonant_and_y?(verb) do
        penultimate_consonant?(verb) && String.ends_with?(verb, "y")
    end

    defp penultimate_consonant?(verb) do
        penultimate = String.slice(verb, -2, 1)
        Regex.match?(~r/[b-df-hj-np-tv-z]/, penultimate)
    end

    defp random_number() do
        Enum.random([:singular, :plural])
    end
end