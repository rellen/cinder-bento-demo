defmodule CinderBentoWeb.BentoTheme do
  @moduledoc """
  The daisyUI Cinder theme, with the grid item wrapper stripped back so that a
  tile fills its whole grid cell: no padding, border or background, just
  rounded corners and a clip. The sort buttons also wrap on narrow screens.
  """
  use Cinder.Theme
  extends :daisy_ui

  set :grid_item_class, "overflow-hidden rounded-2xl shadow-sm"

  # Let the sort buttons wrap on narrow screens instead of overflowing the page.
  set :sort_buttons_class, "flex flex-wrap gap-2"
end
