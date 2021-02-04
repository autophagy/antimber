{ languageserver =
  { elm =
    { command = "elm-language-server"
    , filetypes = [ "elm" ]
    , initializationOptions =
      { elmAnalyseTrigger = "change"
      , elmFormatPath = "elm-format"
      , elmPath = "elm"
      , elmTestPath = "elm-test"
      }
    , rootPatterns = [ "elm.json" ]
    }
  , haskell =
    { args = [ "--lsp" ]
    , command = "haskell-language-server-wrapper"
    , filetypes = [ "hs", "lhs", "haskell" ]
    , initializationOptions.languageServerHaskell
      =
      { formattingProvider = "ormolu", hlintOn = True }
    , rootPatterns = [ "stack.yaml", "cabal.config", "package.yaml" ]
    }
  , java =
    { command = "javals"
    , filetypes = [ "java" ]
    , initializationOptions.extendedClientCapabilities.classFileContentsSupport
      = True
    , settings = {=}
    }
  , python =
    { args = [ "-vv", "--log-file", "/tmp/lsp_python.log" ]
    , command = "pyls"
    , filetypes = [ "python" ]
    , settings.pyls
      =
      { commandPath = ""
      , configurationSources = [ "pycodestyle" ]
      , enable = True
      , plugins =
        { jedi_completion.enabled = True
        , jedi_hover.enabled = True
        , jedi_references.enabled = True
        , jedi_signature_help.enabled = True
        , jedi_symbols = { all_scopes = True, enabled = True }
        , mccabe = { enabled = True, threshold = 15 }
        , preload.enabled = True
        , pycodestyle.enabled = True
        , pydocstyle =
          { enabled = False, match = "(?!test_).*\\.py", matchDir = "[^\\.].*" }
        , pyflakes.enabled = True
        , rope_completion.enabled = True
        }
      , trace.server = "verbose"
      }
    , `trace.server` = "verbose"
    }
  }
  , rust =
    { command = "rls"
    , filetypes = [ "rust" ]
    , settings = {=}
    }
}
