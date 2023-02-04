# A script to generate sticker
#
# Requires some R packages: 'magick', 'hexSticker', 'rsvg', ...,
# and should also install libmagick by `apt install --no-install-recommends libmagick++-dev` for Ubuntu.

# logo_original <- magick::image_read_svg(
#   "https://raw.githubusercontent.com/PRQL/prql-brand/8ff2c16de4488535e1ef3cc2c51d675841032fac/logo/SVG/Logo%202.svg"
# )
logo_original <- magick::image_read(
  "https://github.com/PRQL/prql-brand/raw/8ff2c16de4488535e1ef3cc2c51d675841032fac/logo/PNG/Logo%202.png"
)

# logo <- magick::image_read_svg(
#   "https://raw.githubusercontent.com/PRQL/prql/37ef255e163affbd6c2b6e8d3c89ca6335812fac/website/themes/prql-theme/static/icon.svg" # nolint: line_length_linter.
# ) |>
#   magick::image_resize("6000x") |>
#   magick::image_ggplot()

# logo_gg <- magick::image_crop(logo_original, "600x670+250+190") |>
#   magick::image_ggplot()

# logo_raster <- magick::image_crop(logo_original, "650x650+215+190") |>
#   magick::image_convert(antialias = TRUE) |>
#   as.raster()

# gg <- ggplot2::ggplot() +
#   ggplot2::theme_void() +
#   ggplot2::annotation_raster(logo_raster, -Inf, Inf, -Inf, Inf)

sysfonts::font_add_google("Prompt")

magick::image_crop(logo_original, "650x650+215+190") |>
  hexSticker::sticker(
    package = "prqlr", p_size = 60, s_x = 1, s_y = 0.75, s_width = 1, s_height = 1,
    h_fill = "#010b37", h_color = "#595b82",
    p_family = "Prompt",
    filename = "test.png",
    dpi = 600
  )
