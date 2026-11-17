defmodule CinderBentoWeb.AlbumComponents do
  @moduledoc "Components for rendering albums as bento tiles."
  use Phoenix.Component

  @doc """
  An album tile. It fills its grid cell; how much it shows depends on the tile
  size, which is decided by `album.popularity`.
  """
  attr :album, :map, required: true

  def album_tile(assigns) do
    ~H"""
    <article
      id={"album-#{@album.id}"}
      data-popularity={@album.popularity}
      class="h-full w-full overflow-hidden p-4 text-white"
      style={cover_style(@album.cover_hue)}
    >
      <.tile_body album={@album} size={@album.popularity} />
    </article>
    """
  end

  attr :album, :map, required: true
  attr :size, :atom, required: true

  defp tile_body(%{size: :smash} = assigns) do
    ~H"""
    <div class="flex h-full flex-col justify-between gap-2">
      <span class="badge border-white/40 bg-white/15 text-white">{humanize(@album.genre)}</span>
      <div class="min-h-0">
        <h3 class="line-clamp-2 text-3xl font-extrabold leading-tight sm:text-4xl">{@album.title}</h3>
        <p class="mt-1 truncate text-lg font-medium text-white/90">{@album.artist}</p>
        <p class="mt-2 line-clamp-2 text-sm italic text-white/80">{@album.tagline}</p>
      </div>
      <div class="flex flex-wrap items-center gap-x-3 text-sm font-semibold text-white/90">
        <span>{@album.year}</span>
        <span>{format_rating(@album.rating)}</span>
        <span>{format_streams(@album.streams_millions)}</span>
      </div>
    </div>
    """
  end

  defp tile_body(%{size: :hit} = assigns) do
    ~H"""
    <div class="flex h-full flex-col justify-between gap-2">
      <div class="min-h-0">
        <h3 class="line-clamp-2 text-2xl font-bold leading-tight">{@album.title}</h3>
        <p class="truncate font-medium text-white/90">{@album.artist}</p>
        <p class="mt-1 truncate text-sm italic text-white/80">{@album.tagline}</p>
      </div>
      <p class="text-sm font-semibold text-white/90">{format_streams(@album.streams_millions)}</p>
    </div>
    """
  end

  defp tile_body(%{size: :cult} = assigns) do
    ~H"""
    <div class="flex h-full flex-col justify-between gap-2">
      <div class="min-h-0">
        <h3 class="line-clamp-3 text-xl font-bold leading-tight">{@album.title}</h3>
        <p class="mt-1 truncate text-sm font-medium text-white/90">{@album.artist}</p>
        <p class="mt-3 line-clamp-4 text-sm italic text-white/80">{@album.tagline}</p>
      </div>
      <p class="text-sm font-semibold text-white/90">{format_rating(@album.rating)}</p>
    </div>
    """
  end

  defp tile_body(assigns) do
    ~H"""
    <div class="flex h-full flex-col justify-between gap-2">
      <div class="min-h-0">
        <h3 class="line-clamp-3 text-base font-bold leading-tight">{@album.title}</h3>
        <p class="mt-1 truncate text-sm text-white/90">{@album.artist}</p>
      </div>
      <p class="text-xs font-semibold text-white/80">{@album.year}</p>
    </div>
    """
  end

  defp cover_style(hue) do
    "background: linear-gradient(135deg, hsl(#{hue} 70% 42%), hsl(#{rem(hue + 40, 360)} 75% 24%))"
  end

  defp humanize(genre) do
    genre |> to_string() |> String.replace("_", " ") |> String.capitalize()
  end

  defp format_rating(rating), do: "★ #{:erlang.float_to_binary(rating * 1.0, decimals: 1)}"

  defp format_streams(millions) when millions >= 1000 do
    "#{:erlang.float_to_binary(millions / 1000, decimals: 1)}B streams"
  end

  defp format_streams(millions), do: "#{millions}M streams"
end
