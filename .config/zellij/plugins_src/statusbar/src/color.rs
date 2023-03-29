use zellij_tile::prelude::{InputMode, Palette, PaletteColor, ThemeHue};

pub struct ModeColor {
    pub fg: PaletteColor,
    pub bg: PaletteColor,
}

impl ModeColor {
    pub fn new(mode: InputMode, palette: Palette) -> Self {
        let fg = match palette.theme_hue {
            ThemeHue::Dark => palette.bg,
            ThemeHue::Light => palette.white,
        };

        let bg = match mode {
            InputMode::Locked => palette.red,
            InputMode::Normal => palette.blue,
            _ => palette.orange,
        };

        Self { fg, bg }
    }
}
