defmodule CinderBentoWeb.AlbumLive.Index do
  use CinderBentoWeb, :live_view

  import CinderBentoWeb.AlbumComponents

  @genres [
    {"Rock", :rock},
    {"Pop", :pop},
    {"Jazz", :jazz},
    {"Electronic", :electronic},
    {"Hip hop", :hip_hop},
    {"Classical", :classical},
    {"Folk", :folk}
  ]

  @popularity [
    {"Smash (2×2)", :smash},
    {"Hit (2×1)", :hit},
    {"Cult (1×2)", :cult},
    {"Standard (1×1)", :standard}
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, genres: @genres, popularity_options: @popularity)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section id="intro" class="space-y-3">
        <h1 class="text-3xl font-extrabold tracking-tight sm:text-4xl">Album bento</h1>
        <p class="max-w-3xl text-base-content/70">
          A Cinder grid is just a CSS grid, so tiles can have different sizes. Each album's tile size
          comes from the <code class="font-mono">popularity</code>
          calculation, applied through Cinder's <code class="font-mono">item_class</code>.
        </p>
        <ul id="legend" class="flex flex-wrap gap-2 text-sm">
          <li class="badge badge-neutral">Smash 2×2</li>
          <li class="badge badge-neutral">Hit 2×1</li>
          <li class="badge badge-neutral">Cult 1×2</li>
          <li class="badge badge-neutral">Standard 1×1</li>
        </ul>
      </section>

      <Cinder.collection
        id="albums"
        resource={CinderBento.Music.Album}
        layout={:grid}
        container_class="grid grid-cols-2 md:grid-cols-4 auto-rows-[11rem] grid-flow-dense gap-4"
        item_class={&bento_class/1}
        page_size={16}
        theme={CinderBentoWeb.BentoTheme}
      >
        <:col field="title" search sort={[cycle: [:asc, :desc]]} />
        <:col field="artist" search sort />
        <:col field="genre" filter={[type: :select, prompt: "All genres", options: @genres]} sort />
        <:col
          field="popularity"
          filter={[type: :select, prompt: "All tiers", options: @popularity_options]}
        />
        <:col field="year" filter={[type: :number_range]} sort />
        <:col field="rating" sort />
        <:col field="streams_millions" label="Streams" sort />
        <:item :let={album}><.album_tile album={album} /></:item>
      </Cinder.collection>
    </Layouts.app>
    """
  end

  defp bento_class(%{popularity: :smash}), do: "col-span-2 row-span-2"
  defp bento_class(%{popularity: :hit}), do: "col-span-2"
  defp bento_class(%{popularity: :cult}), do: "row-span-2"
  defp bento_class(_album), do: nil
end
