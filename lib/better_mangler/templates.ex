defmodule BetterMangler.Templates do
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
                [:adjective, :noun, :verb, :adjective, :noun]
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

    def get_random_template_by_length(length) do
        {:ok, list} = Map.fetch(@templates, length)
        Enum.random(list)
    end
end