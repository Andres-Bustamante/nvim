-- /home/desarrollo/.config/nvim/colors/neon-lush.lua
local lush = require("lush")

-- 1. La paleta REAL de Zeioth/Neon (Dark variant)
local p = {
  bg = "#0d0f18", -- El fondo oscuro característico de Neon
  fg = "#cad3Ea", -- El texto principal
  green = "#a6da95", -- Este es el verde "chillón" que vamos a suavizar
  blue = "#8aadf4",
  magenta = "#f5bde6",
  yellow = "#eed49f",
  red = "#ed8796",
  orange = "#f5a97f",
  sky = "#91d7e3",
  gray = "#5b6078",
}

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  -- 2. TRATAMIENTO PARA UNIFORMIDAD
  -- Suavizamos el verde: desaturamos y bajamos brillo
  local soft_green = lush.hsl(p.green).desaturate(30).darken(10)

  -- Suavizamos otros colores para que no "salten" tanto a la vista
  local soft_blue = lush.hsl(p.blue).desaturate(15)
  local soft_magenta = lush.hsl(p.magenta).desaturate(20)

  return {
    -- Base: El fondo profundo de Neon
    Normal({ bg = lush.hsl(p.bg), fg = lush.hsl(p.fg) }),

    DiagnosticUnderlineError({ gui = "none", sp = "none" }),
    DiagnosticUnderlineWarn({ gui = "none", sp = "none" }),
    DiagnosticUnderlineInfo({ gui = "none", sp = "none" }),
    DiagnosticUnderlineHint({ gui = "none", sp = "none" }),

    -- Aplicamos tu verde suave (en Strings y Booleans)
    String({ fg = soft_green }),
    Boolean({ fg = soft_green.lighten(5) }),

    -- Respetamos tus opts: Comentarios en Italic y más uniformes
    Comment({ fg = lush.hsl(p.gray), gui = "italic" }),

    -- Respetamos tus opts: Keywords en Italic
    sym("@keyword")({ fg = soft_magenta, gui = "italic" }),

    -- Respetamos tus opts: Funciones en BOLD (Negrita)
    sym("@function")({ fg = soft_blue, gui = "bold" }),
    Function({ fg = soft_blue, gui = "bold" }),

    -- Treesitter: Para que el código se sienta "uniforme"
    sym("@string")({ fg = soft_green }),
    sym("@variable")({ fg = lush.hsl(p.fg).darken(5) }),
    sym("@constant")({ fg = lush.hsl(p.orange).desaturate(20) }),

    -- 3. BARRA DE ABAJO (No la tocamos)
    StatusLine({ bg = lush.hsl(p.bg).lighten(5), fg = lush.hsl(p.fg) }),
    StatusLineNC({ bg = lush.hsl(p.bg), fg = lush.hsl(p.gray) }),

    -- Paneles laterales y bordes
    WinSeparator({ fg = lush.hsl(p.bg).lighten(10) }),
  }
end)

-- 4. Ejecutar Lush
lush(theme)
