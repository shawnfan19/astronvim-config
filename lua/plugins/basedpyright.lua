-- basedpyright defaults to typeCheckingMode "recommended", which is far
-- noisier than stock pyright; "standard" matches pyright's default.
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = { typeCheckingMode = "standard" },
          },
        },
      },
    },
  },
}
