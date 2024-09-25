@font_family = "BIZ UDPゴシック"

@color_circle_foreground = "black"
@color_circle_background = "white"

@color_circle_color = "#6f95d1"
@color_circle_light_color = "#d2e2ff"
@color_circle_bright_color ="#dfecff"

@color_circle_graffiti_color = "red"

add_image_path("rabbit-images")
@color_circle_open_quote_image = "open-quote-blue.png"
@color_circle_close_quote_image = "close-quote-blue.png"

include_theme("color-circle")

match(TitleSlide, Author) do |authors|
  authors.margin_top = @space * 15
  authors.align = Pango::Alignment::RIGHT
end


include_theme("syntax-highlighting")
