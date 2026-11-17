defmodule CinderBento.Music do
  @moduledoc "Music domain: albums shown in the bento grid."
  use Ash.Domain

  resources do
    resource CinderBento.Music.Album
  end
end
