defmodule CinderBento.Music.AlbumTest do
  use ExUnit.Case, async: false

  require Ash.Query

  alias CinderBento.Music.{Album, Seeds}

  defp popularity(streams, rating) do
    Ash.calculate!(Album, :popularity, refs: %{streams_millions: streams, rating: rating})
  end

  describe "popularity calculation" do
    test "smash: >= 1000M streams and rating >= 4.5" do
      assert popularity(1500, 4.8) == :smash
      assert popularity(1000, 4.5) == :smash
    end

    test "hit: >= 1000M streams, lower rating" do
      assert popularity(1500, 4.4) == :hit
      assert popularity(1000, 2.0) == :hit
    end

    test "cult: high rating, < 1000M streams" do
      assert popularity(999, 4.5) == :cult
      assert popularity(10, 5.0) == :cult
    end

    test "standard: neither" do
      assert popularity(999, 4.4) == :standard
      assert popularity(0, 0.0) == :standard
    end
  end

  describe "seed data" do
    test "has 40 albums with the expected tier distribution" do
      albums = Album |> Ash.Query.load(:popularity) |> Ash.read!()
      assert length(albums) == 40

      assert albums |> Enum.frequencies_by(& &1.popularity) ==
               %{smash: 4, hit: 7, cult: 7, standard: 22}
    end

    test "titles are unique and all genres are present" do
      albums = Ash.read!(Album)
      assert albums |> Enum.map(& &1.title) |> Enum.uniq() |> length() == 40

      genres = albums |> Enum.map(& &1.genre) |> Enum.uniq() |> Enum.sort()
      assert genres == Enum.sort([:rock, :pop, :jazz, :electronic, :hip_hop, :classical, :folk])
    end

    test "years and hues are in range" do
      for album <- Ash.read!(Album) do
        assert album.year in 1965..2026
        assert album.cover_hue in 0..359
      end
    end

    test "Seeds.run/0 is idempotent" do
      assert :ok = Seeds.run()
      assert Ash.count!(Album) == 40
    end
  end

  describe "querying by popularity on ETS" do
    test "filters by the calculation" do
      assert Album |> Ash.Query.filter(popularity == :smash) |> Ash.read!() |> length() == 4

      assert Album |> Ash.Query.filter(popularity in [:hit, :cult]) |> Ash.read!() |> length() ==
               14
    end

    test "sorts by the calculation" do
      albums =
        Album |> Ash.Query.sort(popularity: :asc) |> Ash.Query.load(:popularity) |> Ash.read!()

      tiers = Enum.map(albums, & &1.popularity)
      assert tiers == Enum.sort(tiers)
    end
  end
end
