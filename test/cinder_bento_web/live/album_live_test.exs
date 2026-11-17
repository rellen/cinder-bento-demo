defmodule CinderBentoWeb.AlbumLiveTest do
  use CinderBentoWeb.ConnCase

  import Phoenix.LiveViewTest

  @tile "[data-key=grid_item_class] [data-popularity]"

  defp load_page(conn) do
    {:ok, view, _html} = live(conn, ~p"/")
    render_async(view)
    {:ok, view}
  end

  defp tiles(view) do
    view |> render() |> LazyHTML.from_fragment() |> LazyHTML.query(@tile)
  end

  defp tile_attrs(view, attr) do
    view |> tiles() |> Enum.flat_map(&LazyHTML.attribute(&1, attr))
  end

  defp tile_titles(view) do
    view |> tiles() |> Enum.map(&(&1 |> LazyHTML.query("h3") |> LazyHTML.text()))
  end

  defp filter(view, params) do
    view
    |> form("#albums-filter-form", %{"filters" => params})
    |> render_change()

    render_async(view)
  end

  defp go_to_page(view, page) do
    view |> element("button[title='Go to page #{page}']") |> render_click()
    render_async(view)
  end

  test "renders 16 tiles inside a bento grid container", %{conn: conn} do
    {:ok, view} = load_page(conn)

    assert length(tile_attrs(view, "id")) == 16

    grid = view |> element("[data-key=grid_container_class]") |> render()
    assert grid =~ "grid-flow-dense"
    assert grid =~ "auto-rows-[11rem]"
    assert grid =~ "md:grid-cols-4"
  end

  test "wrapper span classes follow the popularity tier", %{conn: conn} do
    {:ok, view} = load_page(conn)

    wrapper_classes = fn tier ->
      [tile] =
        view
        |> render()
        |> LazyHTML.from_fragment()
        |> LazyHTML.query("[data-popularity=#{tier}]")
        |> Enum.take(1)

      # The wrapper is the tile's parent: query it by the data-key and match on the tile's id
      [id] = LazyHTML.attribute(tile, "id")

      view
      |> render()
      |> LazyHTML.from_fragment()
      |> LazyHTML.query("[data-key=grid_item_class]:has(##{id})")
      |> LazyHTML.attribute("class")
      |> List.first()
      |> String.split()
    end

    # Page 1 is sorted by title and shows all four tiers
    smash = wrapper_classes.("smash")
    assert "col-span-2" in smash and "row-span-2" in smash

    hit = wrapper_classes.("hit")
    assert "col-span-2" in hit and "row-span-2" not in hit

    cult = wrapper_classes.("cult")
    assert "row-span-2" in cult and "col-span-2" not in cult

    standard = wrapper_classes.("standard")
    refute "col-span-2" in standard or "row-span-2" in standard
  end

  test "filtering by popularity = smash leaves the 4 smash albums", %{conn: conn} do
    {:ok, view} = load_page(conn)
    filter(view, %{"popularity" => "smash"})

    assert length(tile_attrs(view, "id")) == 4
    assert tile_attrs(view, "data-popularity") |> Enum.uniq() == ["smash"]
  end

  test "filtering by genre leaves only that genre", %{conn: conn} do
    {:ok, view} = load_page(conn)
    filter(view, %{"genre" => "jazz"})

    expected =
      CinderBento.Music.Album
      |> Ash.read!()
      |> Enum.filter(&(&1.genre == :jazz))
      |> Enum.map(& &1.title)
      |> Enum.sort()

    assert expected != []
    assert Enum.sort(tile_titles(view)) == Enum.map(expected, &String.trim/1)
  end

  test "searching for a seed title finds it", %{conn: conn} do
    {:ok, view} = load_page(conn)

    view |> form("#albums-filter-form", %{"search" => "Glass Cathedral"}) |> render_change()
    render_async(view)

    assert tile_titles(view) == ["Glass Cathedral"]
  end

  test "paginates 40 albums as 16 + 16 + 8", %{conn: conn} do
    {:ok, view} = load_page(conn)
    page1 = tile_attrs(view, "id")

    go_to_page(view, 2)
    page2 = tile_attrs(view, "id")
    assert length(page2) == 16
    assert page1 -- page2 == page1

    go_to_page(view, 3)
    page3 = tile_attrs(view, "id")
    assert length(page3) == 8
    assert Enum.uniq(page1 ++ page2 ++ page3) |> length() == 40
  end
end
