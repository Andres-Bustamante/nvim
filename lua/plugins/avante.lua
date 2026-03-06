-- return {
--   {
--     "yetone/avante.nvim",
--     -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--     -- ⚠️ must add this setting! ! !
--     build = function()
--       -- conditionally use the correct build system for the current OS
--       if vim.fn.has("win32") == 1 then
--         return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
--       else
--         return "make"
--       end
--     end,
--     event = "VeryLazy",
--     version = false, -- Never set this value to "*"! Never!
--     ---@module 'avante'
--     ---@type avante.Config
--     opts = function(_, opts)
--       -- Track avante's internal state during resize
--       local in_resize = false
--       local original_cursor_win = nil
--       local avante_filetypes = { "Avante", "AvanteInput", "AvanteAsk", "AvanteSelectedFiles" }
--
--       -- Check if current window is avante
--       local function is_in_avante_window()
--         local win = vim.api.nvim_get_current_win()
--         local buf = vim.api.nvim_win_get_buf(win)
--         local ft = vim.api.nvim_buf_get_option(buf, "filetype")
--
--         for _, avante_ft in ipairs(avante_filetypes) do
--           if ft == avante_ft then
--             return true, win, ft
--           end
--         end
--         return false
--       end
--
--       -- Temporarily move cursor away from avante during resize
--       local function temporarily_leave_avante()
--         local is_avante, avante_win, avante_ft = is_in_avante_window()
--         if is_avante and not in_resize then
--           in_resize = true
--           original_cursor_win = avante_win
--
--           -- Find a non-avante window to switch to
--           local target_win = nil
--           for _, win in ipairs(vim.api.nvim_list_wins()) do
--             local buf = vim.api.nvim_win_get_buf(win)
--             local ft = vim.api.nvim_buf_get_option(buf, "filetype")
--
--             local is_avante_ft = false
--             for _, aft in ipairs(avante_filetypes) do
--               if ft == aft then
--                 is_avante_ft = true
--                 break
--               end
--             end
--
--             if not is_avante_ft and vim.api.nvim_win_is_valid(win) then
--               target_win = win
--               break
--             end
--           end
--
--           -- Switch to non-avante window if found
--           if target_win then
--             vim.api.nvim_set_current_win(target_win)
--             return true
--           end
--         end
--         return false
--       end
--
--       -- Restore cursor to original avante window
--       local function restore_cursor_to_avante()
--         if in_resize and original_cursor_win and vim.api.nvim_win_is_valid(original_cursor_win) then
--           -- Small delay to ensure resize is complete
--           vim.defer_fn(function()
--             pcall(vim.api.nvim_set_current_win, original_cursor_win)
--             in_resize = false
--             original_cursor_win = nil
--           end, 50)
--         end
--       end
--
--       -- Prevent duplicate windows cleanup
--       local function cleanup_duplicate_avante_windows()
--         local seen_filetypes = {}
--         local windows_to_close = {}
--
--         for _, win in ipairs(vim.api.nvim_list_wins()) do
--           local buf = vim.api.nvim_win_get_buf(win)
--           local ft = vim.api.nvim_buf_get_option(buf, "filetype")
--
--           -- Special handling for Ask and Select Files panels
--           if ft == "AvanteAsk" or ft == "AvanteSelectedFiles" then
--             if seen_filetypes[ft] then
--               -- Found duplicate, mark for closing
--               table.insert(windows_to_close, win)
--             else
--               seen_filetypes[ft] = win
--             end
--           end
--         end
--
--         -- Close duplicate windows
--         for _, win in ipairs(windows_to_close) do
--           if vim.api.nvim_win_is_valid(win) then
--             pcall(vim.api.nvim_win_close, win, true)
--           end
--         end
--       end
--
--       -- Create autocmd group for resize fix
--       vim.api.nvim_create_augroup("AvanteResizeFix", { clear = true })
--
--       -- Main resize handler for Resize
--       vim.api.nvim_create_autocmd({ "VimResized" }, {
--         group = "AvanteResizeFix",
--         callback = function()
--           -- Move cursor away from avante before resize processing
--           local moved = temporarily_leave_avante()
--
--           if moved then
--             -- Let resize happen, then restore cursor
--             vim.defer_fn(function()
--               restore_cursor_to_avante()
--               -- Force a clean redraw
--               vim.cmd("redraw!")
--             end, 100)
--           end
--
--           -- Cleanup duplicates after resize completes
--           vim.defer_fn(cleanup_duplicate_avante_windows, 150)
--         end,
--       })
--
--       -- Prevent avante from responding to scroll/resize events during resize
--       vim.api.nvim_create_autocmd({ "WinScrolled", "WinResized" }, {
--         group = "AvanteResizeFix",
--         pattern = "*",
--         callback = function(args)
--           local buf = args.buf
--           if buf and vim.api.nvim_buf_is_valid(buf) then
--             local ft = vim.api.nvim_buf_get_option(buf, "filetype")
--
--             for _, avante_ft in ipairs(avante_filetypes) do
--               if ft == avante_ft then
--                 -- Prevent event propagation for avante buffers during resize
--                 if in_resize then
--                   return true -- This should stop the event
--                 end
--                 break
--               end
--             end
--           end
--         end,
--       })
--
--       -- Additional cleanup on focus events
--       vim.api.nvim_create_autocmd("FocusGained", {
--         group = "AvanteResizeFix",
--         callback = function()
--           -- Reset resize state on focus gain
--           in_resize = false
--           original_cursor_win = nil
--           -- Clean up any duplicate windows
--           vim.defer_fn(cleanup_duplicate_avante_windows, 100)
--         end,
--       })
--
--       return {
--         -- add any opts here
--         -- for example
--         provider = "copilot",
--         providers = {
--           copilot = {
--             model = "claude-sonnet-4",
--           },
--         },
--         cursor_applying_provider = "copilot",
--         auto_suggestions_provider = "copilot",
--         behaviour = {
--           enable_cursor_planning_mode = true,
--         },
--         -- File selector configuration
--         --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
--         file_selector = {
--           provider = "snacks", -- Avoid native provider issues
--           provider_opts = {},
--         },
--         windows = {
--           ---@type "right" | "left" | "top" | "bottom" | "smart"
--           position = "left", -- the position of the sidebar
--           wrap = true, -- similar to vim.o.wrap
--           width = 30, -- default % based on available width
--           sidebar_header = {
--             enabled = true, -- true, false to enable/disable the header
--             align = "center", -- left, center, right for title
--             rounded = false,
--           },
--           input = {
--             prefix = "> ",
--             height = 8, -- Height of the input window in vertical layout
--           },
--           edit = {
--             start_insert = true, -- Start insert mode when opening the edit window
--           },
--           ask = {
--             floating = false, -- Open the 'AvanteAsk' prompt in a floating window
--             start_insert = true, -- Start insert mode when opening the ask window
--             ---@type "ours" | "theirs"
--             focus_on_apply = "ours", -- which diff to focus after applying
--           },
--         },
--         system_prompt = "Este GPT es un clon del usuario, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.\n\nHabla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es argentino, sin caer en clichés, y utiliza expresiones como 'buenas acá estamos' o 'dale que va' según el contexto.\n\nSus principales áreas de conocimiento incluyen:\n- Desarrollo frontend con Angular, React y gestión de estado avanzada (Redux, Signals, State Managers propios como Gentleman State Manager y GPX-Store).\n- Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.\n- Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.\n- Loco por la modularización, atomic design y el patrón contenedor presentacional \n- Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.\n- Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.\n- Liderazgo de comunidades y creación de contenido en YouTube, Twitch y Discord.\n\nA la hora de explicar un concepto técnico:\n1. Explica el problema que el usuario enfrenta.\n2. Propone una solución clara y directa, con ejemplos si aplica.\n3. Menciona herramientas o recursos que pueden ayudar.\n\nSi el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.\n\nAdemás, tiene experiencia en charlas técnicas y generación de contenido. Puede hablar sobre la importancia de la introspección, có...",
--       }
--     end,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       {
--         -- support for image pasting
--         "HakonHarnes/img-clip.nvim",
--         event = "VeryLazy",
--         opts = {
--           -- recommended settings
--           default = {
--             embed_image_as_base64 = false,
--             prompt_for_file_name = false,
--             drag_and_drop = {
--               insert_mode = true,
--             },
--             -- required for Windows users
--             use_absolute_path = true,
--           },
--         },
--       },
--     },
--   },
-- }
return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- set this if you want to always pull the latest change
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "copilot", -- Recommend using Claude
      -- copilot = {
      -- model = "gpt-4.1",
      -- debug = true, -- Enable debug mode to check logs
      -- },
      web_search_engine = {
        provider = "google", -- google | bing
      },
      auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      behaviour = {
        enable_fastapply = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        enable_cursor_planning_mode = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        auto_aprove_suggestion = false, -- Auto approve suggestion when there is only one
        auto_approve_tool_permissions = false,
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = false },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 35, -- default % based on available width
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = false,
        },
        input = {
          prefix = "󱞩 ",
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          start_insert = true, -- Start insert mode when opening the edit window
          diff_preview = true, -- Show diff preview in the edit window
        },
        ask = {
          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = true, -- Start insert mode when opening the ask window
          ---@type "ours" | "theirs"
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
        --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
        --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
        --- Disable by setting to -1.
        override_timeoutlen = 500,
      },
      system_prompt = "Eres un experto en desarrollo de software, con un rol de arquitecto líder tanto en frontend como en backend. Tu misión es ayudar a desarrolladores con conocimientos intermedios y avanzados a resolver problemas, entender conceptos complejos y aplicar las mejores prácticas en sus proyectos. Tus principales áreas de conocimiento incluyen: 1.  Desarrollo Frontend:    Angular (avanzado, incluyendo RxJS, NgRx/Signals, optimización de rendimiento).    React (avanzado, incluyendo Hooks, Context API, Redux/Zustand/Jotai).      Gestión de estado avanzada y patrones de diseño para UI (por ejemplo, state managers propios, MVVM, MVP).       TypeScript a nivel experto.       HTML5, CSS3, SASS/LESS, y frameworks de UI modernos. 2.  Desarrollo Backend:       Java (versiones recientes, programación funcional, concurrencia).        Spring Boot y su ecosistema (Spring MVC/WebFlux, Spring Data JPA/JDBC, Spring Security, Spring Cloud).       Diseño y construcción de APIs RESTful robustas y seguras.        Patrones de microservicios y comunicación entre servicios (por ejemplo, colas de mensajes como Kafka/RabbitMQ, gRPC).        Manejo de bases de datos relacionales (SQL, optimización de queries, ORMs como Hibernate) y NoSQL (MongoDB, Redis).        Contenerización con Docker y orquestación básica con Kubernetes. 3.  Arquitectura de Software:       Principios SOLID, GRASP, y otros patrones de diseño de software.        Clean Architecture, Arquitectura Hexagonal (Puertos y Adaptadores), Arquitectura Orientada a Servicios (SOA) y Microservicios.        Estrategias de modularización y diseño de componentes/módulos cohesivos y de bajo acoplamiento.        Patrones de diseño específicos para frontend (Contenedor/Presentacional, Atomic Design) y backend (CQRS, Event Sourcing - si aplica). 4.  Buenas Prácticas y Metodologías:       Testing: Pruebas unitarias (JUnit, Mockito para Java; Jest, Vitest, Testing Library para JS/TS), pruebas de integración y E2E (Cypress, Playwright, Selenium). TDD y BDD.       DevOps: Conceptos de CI/CD (Jenkins, GitLab CI, GitHub Actions).       Control de versiones con Git (branching strategies, code reviews).       Código limpio y mantenible. Tu estilo de comunicación:    Lenguaje: Español neutro, claro, preciso y profesional, pero siempre accesible y amigable. Evita la jerga excesiva a menos que sea estrictamente necesario y explícala si la usas.    Tono: Técnico pero práctico. Ofrece explicaciones claras y aplicables, con ejemplos de código útiles y relevantes cuando sea necesario.    Enfoque: Directo y pragmático. Ve al grano, pero asegúrate de que el usuario comprenda los conceptos. Metodología para explicar conceptos técnicos: 1.  Identifica el Problema: Asegúrate de entender la necesidad o el problema que el usuario está tratando de resolver.  2.  Propón una Solución: Ofrece una solución clara y directa. Si es un concepto, explícalo de manera estructurada.        Proporciona ejemplos de código concisos y funcionales (en Java/Spring Boot para backend, TypeScript/Angular/React para frontend, según corresponda).       Utiliza analogías prácticas si el tema es muy complejo (la construcción, la ingeniería, etc., pueden ser buenas fuentes). 3.  Menciona Herramientas y Recursos: Sugiere herramientas, librerías, patrones o recursos adicionales que puedan ayudar al usuario a profundizar o implementar la solución. 4.  Utilidad: Cuando menciones una herramienta, patrón o concepto, explica brevemente su utilidad y cómo se aplica en el contexto de la discusión, evitando redundancias. Objetivo final: Empoderar al usuario con conocimiento práctico y soluciones efectivas, fomentando las buenas prácticas y la excelencia técnica.",
    },
    -- config = function(_, opts)
    --   vim.keymap.set("n", "<C-x>", function()
    --     vim.cmd("AvanteClear")
    --   end, { desc = "Avante: Limpiar Chat", silent = true })
    -- end,
    -- build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
