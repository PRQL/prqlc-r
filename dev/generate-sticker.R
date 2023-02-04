# A script to generate sticker
#
# Requires some R packages: 'magick', 'hexSticker', 'rsvg', ...,
# and should also install libmagick by `apt install --no-install-recommends libmagick++-dev` for Ubuntu.
#
# Usage: Rscript dev/generate-sticker.R

logo_path <- file.path("man", "figures", "logo.png")

logo_original <- magick::image_read(
  "https://github.com/PRQL/prql-brand/raw/8ff2c16de4488535e1ef3cc2c51d675841032fac/logo/PNG/Logo%202.png"
)

sysfonts::font_add_google("Prompt")

magick::image_crop(logo_original, "650x650+215+190") |>
  hexSticker::sticker(
    package = "prqlr", p_family = "Prompt", p_size = 50, p_y = 1.5,
    s_x = 1, s_y = 0.75, s_width = 1, s_height = 1,
    h_fill = "#010b37", h_color = "#595b82",
    dpi = 500,
    filename = logo_path
  )
