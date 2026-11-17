# cinder-bento-demo

A small Phoenix LiveView app that shows how to make a bento layout (a grid where
the tiles have different sizes) with [Cinder](https://hexdocs.pm/cinder) and
[Ash](https://hexdocs.pm/ash). The data is in an Ash ETS resource, so the app
needs no database.

## Run it

Get Erlang and Elixir with devenv or with mise, then start the app.

```sh
direnv allow        # devenv (or: devenv shell)
mise install        # mise (or asdf), from .tool-versions

mix setup
mix phx.server      # http://localhost:4000
```

The two environments give the same versions: Erlang/OTP 29.1.2 and Elixir
1.20.5. If you change a version, change it in `devenv.nix` and in
`.tool-versions`.

## How the bento layout works

A Cinder grid is a CSS grid. Three things make it a bento layout.

1. **The record supplies its tile size.** `CinderBento.Music.Album` has a
   `popularity` expression calculation that gives `:smash`, `:hit`, `:cult`, or
   `:standard`. See `lib/cinder_bento/music/album.ex`.
2. **`container_class` sets the grid.** It replaces the default grid classes of
   Cinder. `auto-rows-[11rem]` gives each row a fixed height, and
   `grid-flow-dense` lets small tiles fill the holes that large tiles leave.
3. **`item_class` sets the span of each tile.** Cinder calls the function with
   each record and adds the result to the wrapper of the item.

```heex
<Cinder.collection
  id="albums"
  resource={CinderBento.Music.Album}
  layout={:grid}
  container_class="grid grid-cols-2 md:grid-cols-4 auto-rows-[11rem] grid-flow-dense gap-4"
  item_class={&bento_class/1}
  page_size={16}
  theme={CinderBentoWeb.BentoTheme}
>
  <:col field="popularity" filter />
  <:item :let={album}><.album_tile album={album} /></:item>
</Cinder.collection>
```

```elixir
defp bento_class(%{popularity: :smash}), do: "col-span-2 row-span-2"
defp bento_class(%{popularity: :hit}), do: "col-span-2"
defp bento_class(%{popularity: :cult}), do: "row-span-2"
defp bento_class(_album), do: nil
```

Notes:

- Cinder loads the fields of the `<:col>` slots, so `<:col field="popularity">`
  is sufficient to load the calculation.
- Tailwind must see each class as a complete literal string. Do not build
  `col-span-*` names with interpolation.
- `CinderBentoWeb.BentoTheme` extends the `daisy_ui` theme and removes the
  padding and border of the item wrapper, so the tile fills its grid cell.
- `CinderBentoWeb.AlbumComponents.album_tile/1` shows more detail on larger
  tiles.

The full page is in `lib/cinder_bento_web/live/album_live/index.ex`.

## Tests

```sh
mix test
```
