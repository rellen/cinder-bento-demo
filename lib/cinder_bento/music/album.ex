defmodule CinderBento.Music.Album do
  @moduledoc "An album, stored in the shared ETS table."
  use Ash.Resource,
    domain: CinderBento.Music,
    data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string, allow_nil?: false, public?: true
    attribute :artist, :string, allow_nil?: false, public?: true

    attribute :genre, :atom,
      allow_nil?: false,
      public?: true,
      constraints: [one_of: [:rock, :pop, :jazz, :electronic, :hip_hop, :classical, :folk]]

    attribute :year, :integer, allow_nil?: false, public?: true

    attribute :rating, :float,
      allow_nil?: false,
      public?: true,
      constraints: [min: 0.0, max: 5.0]

    attribute :streams_millions, :integer,
      allow_nil?: false,
      public?: true,
      constraints: [min: 0]

    attribute :tagline, :string, allow_nil?: false, public?: true

    attribute :cover_hue, :integer,
      allow_nil?: false,
      public?: true,
      constraints: [min: 0, max: 359]
  end

  calculations do
    calculate :popularity,
              :atom,
              expr(
                cond do
                  streams_millions >= 1000 and rating >= 4.5 -> :smash
                  streams_millions >= 1000 -> :hit
                  rating >= 4.5 -> :cult
                  true -> :standard
                end
              ),
              constraints: [one_of: [:smash, :hit, :cult, :standard]],
              public?: true,
              description: "Popularity tier derived from streams and rating."
  end
end
