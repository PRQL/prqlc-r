# A script to generate sticker
#
# Requires some R packages: 'magick', 'hexSticker', 'rsvg', ...,
# and should also install libmagick by `apt install --no-install-recommends libmagick++-dev` for Ubuntu.
#
# Usage: Rscript dev/generate-sticker.R

logo_path <- file.path("man", "figures", "logo.png")

logo_original <- magick::image_read(
  "https://raw.githubusercontent.com/PRQL/prql-brand/c73248897ec3aadea97122f119280bb87b14934d/logo/PNG/logo-image.png"
)

sysfonts::font_add_google("Prompt")

logo_original |>
  hexSticker::sticker(
    package = "prqlr", p_family = "Prompt", p_size = 50, p_y = 1.5,
    s_x = 1, s_y = 0.75, s_width = 1.1, s_height = 1.1,
    h_fill = "#010b37", h_color = "#595b82",
    dpi = 500,
    filename = logo_path
  )
