defmodule CinderBento.Music.Seeds do
  @moduledoc """
  Seeds 40 fictional albums into the ETS-backed `Album` resource.

  Runs synchronously from the supervision tree (before the endpoint starts) and
  is idempotent.
  """
  alias CinderBento.Music.Album

  # Popularity tiers: 4 smash, 7 hit, 7 cult, 22 standard (in that order).

  @albums [
    %{
      title: "Glass Cathedral",
      artist: "The Hollow Lanterns",
      genre: :rock,
      year: 1994,
      rating: 4.8,
      streams_millions: 2450,
      tagline: "Towering riffs echo through an abandoned church.",
      cover_hue: 0
    },
    %{
      title: "Neon Lullabies",
      artist: "Mira Valcourt",
      genre: :pop,
      year: 2019,
      rating: 4.7,
      streams_millions: 3820,
      tagline: "Bright hooks wrapped around late-night loneliness.",
      cover_hue: 137
    },
    %{
      title: "Concrete Psalms",
      artist: "Dusty Okonkwo",
      genre: :hip_hop,
      year: 2011,
      rating: 4.9,
      streams_millions: 1720,
      tagline: "Streetlight poetry over dusty drum breaks.",
      cover_hue: 274
    },
    %{
      title: "Midnight Operator",
      artist: "Kilo Meridian",
      genre: :electronic,
      year: 2016,
      rating: 4.6,
      streams_millions: 1380,
      tagline: "Pulsing synths for a city that never sleeps.",
      cover_hue: 51
    },
    %{
      title: "Sugar Static",
      artist: "Pastel Riot",
      genre: :pop,
      year: 2022,
      rating: 4.1,
      streams_millions: 2210,
      tagline: "Glitter-coated choruses with a static crackle.",
      cover_hue: 188
    },
    %{
      title: "Rust and Thunder",
      artist: "The Burning Almanac",
      genre: :rock,
      year: 1987,
      rating: 4.3,
      streams_millions: 1540,
      tagline: "Road-worn anthems built for loud amplifiers.",
      cover_hue: 325
    },
    %{
      title: "Chrome Horizon",
      artist: "Voltaire Lane",
      genre: :electronic,
      year: 2008,
      rating: 3.9,
      streams_millions: 1120,
      tagline: "Sleek arpeggios chase an endless skyline.",
      cover_hue: 102
    },
    %{
      title: "Block Party Ghosts",
      artist: "Tre Valentino",
      genre: :hip_hop,
      year: 2015,
      rating: 4.2,
      streams_millions: 1860,
      tagline: "Summer cookout bangers haunted by old friends.",
      cover_hue: 239
    },
    %{
      title: "Heartbeat Parade",
      artist: "Juniper Skye",
      genre: :pop,
      year: 2003,
      rating: 3.7,
      streams_millions: 1260,
      tagline: "A marching band of bubbly confessions.",
      cover_hue: 16
    },
    %{
      title: "Wildflower Telegram",
      artist: "Ansel Wren",
      genre: :folk,
      year: 2018,
      rating: 4.4,
      streams_millions: 1090,
      tagline: "Gentle strumming carries news from the hills.",
      cover_hue: 153
    },
    %{
      title: "Velvet Taxi",
      artist: "Cass Montrose Quartet",
      genre: :jazz,
      year: 2021,
      rating: 4.0,
      streams_millions: 1010,
      tagline: "Smoky grooves for a slow ride downtown.",
      cover_hue: 290
    },
    %{
      title: "Lunar Marginalia",
      artist: "Odile Fenwick",
      genre: :jazz,
      year: 1972,
      rating: 4.8,
      streams_millions: 310,
      tagline: "Improvised notes scribbled in the margins of the moon.",
      cover_hue: 67
    },
    %{
      title: "Salt Chapel Requiem",
      artist: "Ensemble Verdigris",
      genre: :classical,
      year: 2005,
      rating: 4.7,
      streams_millions: 85,
      tagline: "Strings and silence in a seaside chapel.",
      cover_hue: 204
    },
    %{
      title: "Barnwood Hymnal",
      artist: "Old Tom Peabody",
      genre: :folk,
      year: 1969,
      rating: 4.6,
      streams_millions: 140,
      tagline: "Hand-recorded hymns from a drafty barn.",
      cover_hue: 341
    },
    %{
      title: "Tape Hiss Cathedral",
      artist: "Null Pointers",
      genre: :electronic,
      year: 1999,
      rating: 4.9,
      streams_millions: 260,
      tagline: "Lo-fi drones from a cassette left in the rain.",
      cover_hue: 118
    },
    %{
      title: "Basement Oracle",
      artist: "Fugue Cartel",
      genre: :rock,
      year: 1991,
      rating: 4.6,
      streams_millions: 420,
      tagline: "Feedback prophecies recorded below ground level.",
      cover_hue: 255
    },
    %{
      title: "Blue Room Sessions",
      artist: "Hazel Quint",
      genre: :jazz,
      year: 1965,
      rating: 4.7,
      streams_millions: 95,
      tagline: "One take, one microphone, one blue room.",
      cover_hue: 32
    },
    %{
      title: "Nocturne for Foxes",
      artist: "Lucien Aldermere",
      genre: :classical,
      year: 2013,
      rating: 4.6,
      streams_millions: 180,
      tagline: "Piano miniatures for creatures of the night.",
      cover_hue: 169
    },
    %{
      title: "Paper Planes Over Ohio",
      artist: "Saturday Mailmen",
      genre: :rock,
      year: 2001,
      rating: 3.4,
      streams_millions: 540,
      tagline: "Breezy guitars and cheerful homesickness.",
      cover_hue: 306
    },
    %{
      title: "Second Gear",
      artist: "The Lowlands",
      genre: :rock,
      year: 1978,
      rating: 3.8,
      streams_millions: 760,
      tagline: "Mid-tempo rockers that never quite floor it.",
      cover_hue: 83
    },
    %{
      title: "Garage Sale Heroes",
      artist: "Brickyard Kids",
      genre: :rock,
      year: 2009,
      rating: 3.1,
      streams_millions: 230,
      tagline: "Scrappy chords and secondhand dreams.",
      cover_hue: 220
    },
    %{
      title: "Postcard Pop",
      artist: "Lola Marchetti",
      genre: :pop,
      year: 1996,
      rating: 3.6,
      streams_millions: 690,
      tagline: "Sunny little songs sent from imaginary beaches.",
      cover_hue: 357
    },
    %{
      title: "Rewind Romance",
      artist: "Bexley Hart",
      genre: :pop,
      year: 2012,
      rating: 3.3,
      streams_millions: 470,
      tagline: "Cassette-era crushes remixed for today.",
      cover_hue: 134
    },
    %{
      title: "Confetti Season",
      artist: "The Daydream Bureau",
      genre: :pop,
      year: 2025,
      rating: 4.0,
      streams_millions: 920,
      tagline: "Party-ready earworms with a wistful edge.",
      cover_hue: 271
    },
    %{
      title: "Corner Store Cadence",
      artist: "Mikko Zane",
      genre: :hip_hop,
      year: 2000,
      rating: 3.9,
      streams_millions: 610,
      tagline: "Laid-back rhymes from behind the counter.",
      cover_hue: 48
    },
    %{
      title: "Bassline Diaries",
      artist: "Sol Hendricks",
      genre: :hip_hop,
      year: 2007,
      rating: 4.3,
      streams_millions: 980,
      tagline: "Deep grooves and handwritten confessions.",
      cover_hue: 185
    },
    %{
      title: "Roof Cypher",
      artist: "Nadia Cruz",
      genre: :hip_hop,
      year: 2020,
      rating: 3.5,
      streams_millions: 350,
      tagline: "Rooftop freestyles at golden hour.",
      cover_hue: 322
    },
    %{
      title: "Skyline Freestyle",
      artist: "Jet Marlowe",
      genre: :hip_hop,
      year: 2024,
      rating: 3.2,
      streams_millions: 720,
      tagline: "Fast flows over borrowed city sounds.",
      cover_hue: 99
    },
    %{
      title: "Circuit Bloom",
      artist: "Pixel Orchard",
      genre: :electronic,
      year: 2010,
      rating: 3.8,
      streams_millions: 540,
      tagline: "Gentle glitches blossom into dance floor flowers.",
      cover_hue: 236
    },
    %{
      title: "Subway Aurora",
      artist: "Dub Constellation",
      genre: :electronic,
      year: 2014,
      rating: 4.1,
      streams_millions: 810,
      tagline: "Underground rhythms lit by a faint glow.",
      cover_hue: 13
    },
    %{
      title: "Analog Daydreams",
      artist: "Fern Lattice",
      genre: :electronic,
      year: 1983,
      rating: 3.6,
      streams_millions: 190,
      tagline: "Warm oscillators drifting through the afternoon.",
      cover_hue: 150
    },
    %{
      title: "River Table Songs",
      artist: "The Quiet Orchards",
      genre: :folk,
      year: 1975,
      rating: 4.0,
      streams_millions: 330,
      tagline: "Kitchen-table melodies carried downstream.",
      cover_hue: 287
    },
    %{
      title: "Harvest Moon Inn",
      artist: "Willa Thorne",
      genre: :folk,
      year: 2006,
      rating: 3.7,
      streams_millions: 570,
      tagline: "Fireside tales from a cozy roadside inn.",
      cover_hue: 64
    },
    %{
      title: "Porch Light Ballads",
      artist: "Elias Ward",
      genre: :folk,
      year: 2023,
      rating: 4.3,
      streams_millions: 740,
      tagline: "Soft guitar songs for the last hour of dusk.",
      cover_hue: 201
    },
    %{
      title: "Mountain Mailbox",
      artist: "Birch and Bramble",
      genre: :folk,
      year: 1988,
      rating: 3.4,
      streams_millions: 150,
      tagline: "Letters from a cabin with no cell service.",
      cover_hue: 338
    },
    %{
      title: "Back Alley Brass",
      artist: "Marlowe Fitch Trio",
      genre: :jazz,
      year: 1981,
      rating: 4.1,
      streams_millions: 260,
      tagline: "Muted trumpets and the clink of late glasses.",
      cover_hue: 115
    },
    %{
      title: "Rainy Day Standards",
      artist: "Odessa Lund",
      genre: :jazz,
      year: 2002,
      rating: 3.9,
      streams_millions: 430,
      tagline: "Familiar tunes reshaped by a drizzly afternoon.",
      cover_hue: 252
    },
    %{
      title: "Quiet Observatory",
      artist: "Camille Roux Orchestra",
      genre: :classical,
      year: 2026,
      rating: 4.2,
      streams_millions: 120,
      tagline: "Chamber pieces for stargazers and insomniacs.",
      cover_hue: 29
    },
    %{
      title: "Sonata in Soft Focus",
      artist: "Ivor Lindqvist",
      genre: :classical,
      year: 1998,
      rating: 3.8,
      streams_millions: 210,
      tagline: "Gauzy piano lines with blurred edges.",
      cover_hue: 166
    },
    %{
      title: "Winter Garden Suite",
      artist: "Philharmonia Aurelia",
      genre: :classical,
      year: 1985,
      rating: 4.4,
      streams_millions: 300,
      tagline: "Orchestral frost on a glass-roofed garden.",
      cover_hue: 303
    }
  ]

  def child_spec(opts) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opts]}, restart: :temporary}
  end

  def start_link(_opts) do
    run()
    :ignore
  end

  @doc "Inserts the seed albums unless any album already exists."
  def run do
    if Ash.exists?(Album) do
      :ok
    else
      Ash.bulk_create!(@albums, Album, :create,
        return_errors?: true,
        stop_on_error?: true,
        authorize?: false
      )

      :ok
    end
  end
end
