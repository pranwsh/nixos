local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("doc", {
    t("\\documentclass[12pt]{article}"),
    -- ...rest of snippet
    --
    t("\\end{document}"),
  }),
}
