-- =============================================================================
-- ~/.config/nvim/lua/snippets/tex.lua
-- Comprehensive LuaSnip snippets for LaTeX
-- Load with:
--   require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
-- =============================================================================

local ls  = require("luasnip")
local s   = ls.snippet
local sn  = ls.snippet_node
local t   = ls.text_node
local i   = ls.insert_node
local f   = ls.function_node
local c   = ls.choice_node
local d   = ls.dynamic_node
local r   = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- =============================================================================
-- HELPERS
-- =============================================================================

-- Wrap a single insert node in a LaTeX command: \cmd{<cursor>}
local function cmd(trigger, latex_cmd, desc)
  return s({ trig = trigger, desc = desc or latex_cmd }, fmt("\\" .. latex_cmd .. "{{{}}}", { i(1) }))
end

-- =============================================================================
-- SNIPPETS
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- DOCUMENT TEMPLATES
  -- ---------------------------------------------------------------------------

  s({ trig = "doc", desc = "Full article document template" }, fmt([[
\documentclass[12pt]{{article}}

% ---------- Encoding & fonts ----------
\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}

% ---------- Language ----------
\usepackage[english]{{babel}}

% ---------- Page geometry ----------
\usepackage{{geometry}}
\geometry{{margin=1in}}

% ---------- Math ----------
\usepackage{{amsmath, amssymb, amsthm}}

% ---------- Graphics ----------
\usepackage{{graphicx}}
\usepackage{{float}}

% ---------- Tables ----------
\usepackage{{booktabs}}
\usepackage{{array}}

% ---------- Lists ----------
\usepackage{{enumitem}}

% ---------- Links ----------
\usepackage{{hyperref}}
\hypersetup{{
  colorlinks = true,
  linkcolor  = blue,
  urlcolor   = blue,
  citecolor  = red,
}}

% ---------- Bibliography ----------
% \usepackage[style=authoryear]{{biblatex}}
% \addbibresource{{references.bib}}

% ---------- Theorems ----------
\theoremstyle{{plain}}
\newtheorem{{theorem}}{{Theorem}}[section]
\newtheorem{{lemma}}[theorem]{{Lemma}}
\newtheorem{{corollary}}[theorem]{{Corollary}}
\newtheorem{{proposition}}[theorem]{{Proposition}}
\theoremstyle{{definition}}
\newtheorem{{definition}}[theorem]{{Definition}}
\newtheorem{{example}}[theorem]{{Example}}
\theoremstyle{{remark}}
\newtheorem*{{remark}}{{Remark}}

% ---------- Metadata ----------
\title{{{}}}
\author{{{}}}
\date{{{}}}

\begin{{document}}

\maketitle
\tableofcontents
\newpage

{}

\end{{document}}
]], { i(1, "Title"), i(2, "Author"), i(3, "\\today"), i(4) })),

  s({ trig = "docbeamer", desc = "Beamer presentation template" }, fmt([[
\documentclass{{beamer}}

\usetheme{{{}}}
\usecolortheme{{{}}}

\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}
\usepackage{{amsmath, amssymb}}
\usepackage{{graphicx}}

\title{{{}}}
\subtitle{{{}}}
\author{{{}}}
\institute{{{}}}
\date{{{}}}

\begin{{document}}

\begin{{frame}}
  \titlepage
\end{{frame}}

\begin{{frame}}{{Outline}}
  \tableofcontents
\end{{frame}}

{}

\end{{document}}
]], {
    i(1, "Madrid"),
    i(2, "default"),
    i(3, "Title"),
    i(4, "Subtitle"),
    i(5, "Author"),
    i(6, "Institute"),
    i(7, "\\today"),
    i(8),
  })),

  s({ trig = "docreport", desc = "Report / thesis document template" }, fmt([[
\documentclass[12pt, a4paper]{{report}}

\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}
\usepackage[english]{{babel}}
\usepackage{{geometry}}
\geometry{{margin=1in}}
\usepackage{{amsmath, amssymb, amsthm}}
\usepackage{{graphicx}}
\usepackage{{float}}
\usepackage{{booktabs}}
\usepackage{{hyperref}}
\usepackage{{setspace}}
\doublespacing

\title{{{}}}
\author{{{}}}
\date{{{}}}

\begin{{document}}

\maketitle
\begin{{abstract}}
  {}
\end{{abstract}}

\tableofcontents
\newpage

{}

% \bibliography{{references}}
% \bibliographystyle{{plain}}

\end{{document}}
]], { i(1, "Title"), i(2, "Author"), i(3, "\\today"), i(4, "Abstract text."), i(5) })),

  -- ---------------------------------------------------------------------------
  -- STRUCTURE
  -- ---------------------------------------------------------------------------

  s({ trig = "sec", desc = "\\section" }, fmt("\\section{{{}}}\n{}", { i(1), i(2) })),
  s({ trig = "ssec", desc = "\\subsection" }, fmt("\\subsection{{{}}}\n{}", { i(1), i(2) })),
  s({ trig = "sssec", desc = "\\subsubsection" }, fmt("\\subsubsection{{{}}}\n{}", { i(1), i(2) })),
  s({ trig = "par", desc = "\\paragraph" }, fmt("\\paragraph{{{}}}\n{}", { i(1), i(2) })),

  s({ trig = "sec*", desc = "\\section* (unnumbered)" }, fmt("\\section*{{{}}}\n{}", { i(1), i(2) })),
  s({ trig = "ssec*", desc = "\\subsection* (unnumbered)" }, fmt("\\subsection*{{{}}}\n{}", { i(1), i(2) })),

  -- ---------------------------------------------------------------------------
  -- ENVIRONMENTS  (generic + common specific ones)
  -- ---------------------------------------------------------------------------

  -- Generic begin/end
  s({ trig = "beg", desc = "Generic \\begin{} / \\end{}" }, fmt([[
\begin{{{}}}
  {}
\end{{{}}}
]], { i(1, "environment"), i(2), rep(1) })),

  -- Math environments
  s({ trig = "eq", desc = "equation environment" }, fmt([[
\begin{{equation}}
  {}
\end{{equation}}
]], { i(1) })),

  s({ trig = "eq*", desc = "equation* environment" }, fmt([[
\begin{{equation*}}
  {}
\end{{equation*}}
]], { i(1) })),

  s({ trig = "ali", desc = "align environment" }, fmt([[
\begin{{align}}
  {} &= {} \\\\
\end{{align}}
]], { i(1), i(2) })),

  s({ trig = "ali*", desc = "align* environment" }, fmt([[
\begin{{align*}}
  {} &= {} \\\\
\end{{align*}}
]], { i(1), i(2) })),

  s({ trig = "gat", desc = "gather environment" }, fmt([[
\begin{{gather*}}
  {}
\end{{gather*}}
]], { i(1) })),

  s({ trig = "cas", desc = "cases environment" }, fmt([[
\begin{{cases}}
  {} & {} \\\\
  {} & {}
\end{{cases}}
]], { i(1), i(2), i(3), i(4) })),

  -- Lists
  s({ trig = "ite", desc = "itemize environment" }, fmt([[
\begin{{itemize}}
  \item {}
\end{{itemize}}
]], { i(1) })),

  s({ trig = "enu", desc = "enumerate environment" }, fmt([[
\begin{{enumerate}}
  \item {}
\end{{enumerate}}
]], { i(1) })),

  s({ trig = "desc", desc = "description environment" }, fmt([[
\begin{{description}}
  \item[{}] {}
\end{{description}}
]], { i(1, "term"), i(2) })),

  s({ trig = "item", desc = "\\item" }, t("\\item ")),

  -- Figures
  s({ trig = "fig", desc = "figure environment" }, fmt([[
\begin{{figure}}[{}]
  \centering
  \includegraphics[width={}]{{{}}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{figure}}
]], { i(1, "htbp"), i(2, "0.8\\textwidth"), i(3, "filename"), i(4, "Caption"), i(5) })),

  s({ trig = "subfig", desc = "figure with two subfigures" }, fmt([[
\begin{{figure}}[htbp]
  \centering
  \begin{{subfigure}}[b]{{0.45\textwidth}}
    \centering
    \includegraphics[width=\textwidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
  \end{{subfigure}}
  \hfill
  \begin{{subfigure}}[b]{{0.45\textwidth}}
    \centering
    \includegraphics[width=\textwidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
  \end{{subfigure}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{figure}}
]], { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8) })),

  -- Tables
  s({ trig = "tab", desc = "table + tabular environment" }, fmt([[
\begin{{table}}[{}]
  \centering
  \caption{{{}}}
  \label{{tab:{}}}
  \begin{{tabular}}{{{}}}
    \toprule
    {} \\\\
    \midrule
    {} \\\\
    \bottomrule
  \end{{tabular}}
\end{{table}}
]], { i(1, "htbp"), i(2, "Caption"), i(3), i(4, "l l l"), i(5, "Col1 & Col2 & Col3"), i(6) })),

  -- Theorem-like
  s({ trig = "thm", desc = "theorem environment" }, fmt([[
\begin{{theorem}}[{}]
  {}
\end{{theorem}}
]], { i(1, "name"), i(2) })),

  s({ trig = "lem", desc = "lemma environment" }, fmt([[
\begin{{lemma}}[{}]
  {}
\end{{lemma}}
]], { i(1, "name"), i(2) })),

  s({ trig = "cor", desc = "corollary environment" }, fmt([[
\begin{{corollary}}
  {}
\end{{corollary}}
]], { i(1) })),

  s({ trig = "def", desc = "definition environment" }, fmt([[
\begin{{definition}}[{}]
  {}
\end{{definition}}
]], { i(1, "name"), i(2) })),

  s({ trig = "prop", desc = "proposition environment" }, fmt([[
\begin{{proposition}}
  {}
\end{{proposition}}
]], { i(1) })),

  s({ trig = "prf", desc = "proof environment" }, fmt([[
\begin{{proof}}
  {}
\end{{proof}}
]], { i(1) })),

  s({ trig = "exmp", desc = "example environment" }, fmt([[
\begin{{example}}
  {}
\end{{example}}
]], { i(1) })),

  s({ trig = "rem", desc = "remark environment" }, fmt([[
\begin{{remark}}
  {}
\end{{remark}}
]], { i(1) })),

  -- Verbatim / code
  s({ trig = "verb", desc = "verbatim environment" }, fmt([[
\begin{{verbatim}}
{}
\end{{verbatim}}
]], { i(1) })),

  s({ trig = "lst", desc = "lstlisting environment" }, fmt([[
\begin{{lstlisting}}[language={}, caption={{{}}}]
{}
\end{{lstlisting}}
]], { i(1, "Python"), i(2, "Caption"), i(3) })),

  s({ trig = "mint", desc = "minted environment" }, fmt([[
\begin{{minted}}{{{}}}
{}
\end{{minted}}
]], { i(1, "python"), i(2) })),

  -- Beamer frames
  s({ trig = "frame", desc = "beamer frame" }, fmt([[
\begin{{frame}}{{{}}}
  {}
\end{{frame}}
]], { i(1, "Title"), i(2) })),

  s({ trig = "block", desc = "beamer block" }, fmt([[
\begin{{block}}{{{}}}
  {}
\end{{block}}
]], { i(1, "Block title"), i(2) })),

  s({ trig = "col2", desc = "beamer two columns" }, fmt([[
\begin{{columns}}
  \begin{{column}}{{0.5\textwidth}}
    {}
  \end{{column}}
  \begin{{column}}{{0.5\textwidth}}
    {}
  \end{{column}}
\end{{columns}}
]], { i(1), i(2) })),

  -- Minipage / box
  s({ trig = "mini", desc = "minipage" }, fmt([[
\begin{{minipage}}{{{}}}
  {}
\end{{minipage}}
]], { i(1, "0.5\\textwidth"), i(2) })),

  -- Abstract
  s({ trig = "abs", desc = "abstract environment" }, fmt([[
\begin{{abstract}}
  {}
\end{{abstract}}
]], { i(1) })),

  -- ---------------------------------------------------------------------------
  -- INLINE MATH
  -- ---------------------------------------------------------------------------

  s({ trig = "mk", desc = "inline math $...$" }, fmt("${}$", { i(1) })),

  s({ trig = "dm", desc = "display math \\[...\\]" }, fmt([[
\[
  {}
\]
]], { i(1) })),

  -- ---------------------------------------------------------------------------
  -- MATH CONSTRUCTS
  -- ---------------------------------------------------------------------------

  s({ trig = "frac", desc = "\\frac{}{}" }, fmt("\\frac{{{}}}{{{}}}", { i(1, "num"), i(2, "den") })),
  s({ trig = "dfrac", desc = "\\dfrac{}{}" }, fmt("\\dfrac{{{}}}{{{}}}", { i(1, "num"), i(2, "den") })),
  s({ trig = "sqrt", desc = "\\sqrt{}" }, fmt("\\sqrt{{{}}}", { i(1) })),
  s({ trig = "sqrtn", desc = "\\sqrt[n]{}" }, fmt("\\sqrt[{}]{{{}}}", { i(1, "n"), i(2) })),

  s({ trig = "sum", desc = "\\sum with limits" }, fmt("\\sum_{{{}}}^{{{}}}", { i(1, "i=0"), i(2, "n") })),
  s({ trig = "prod", desc = "\\prod with limits" }, fmt("\\prod_{{{}}}^{{{}}}", { i(1, "i=0"), i(2, "n") })),
  s({ trig = "lim", desc = "\\lim" }, fmt("\\lim_{{{}}}", { i(1, "n \\to \\infty") })),
  s({ trig = "limsup", desc = "\\limsup" }, fmt("\\limsup_{{{}}}", { i(1, "n \\to \\infty") })),
  s({ trig = "liminf", desc = "\\liminf" }, fmt("\\liminf_{{{}}}", { i(1, "n \\to \\infty") })),

  s({ trig = "int", desc = "\\int with limits" }, fmt("\\int_{{{}}}^{{{}}}", { i(1, "0"), i(2, "\\infty") })),
  s({ trig = "iint", desc = "\\iint" }, fmt("\\iint_{{{}}}", { i(1) })),
  s({ trig = "oint", desc = "\\oint" }, fmt("\\oint_{{{}}}", { i(1) })),

  s({ trig = "mat", desc = "pmatrix" }, fmt([[
\begin{{pmatrix}}
  {}
\end{{pmatrix}}
]], { i(1) })),

  s({ trig = "bmat", desc = "bmatrix" }, fmt([[
\begin{{bmatrix}}
  {}
\end{{bmatrix}}
]], { i(1) })),

  s({ trig = "vmat", desc = "vmatrix (determinant)" }, fmt([[
\begin{{vmatrix}}
  {}
\end{{vmatrix}}
]], { i(1) })),

  s({ trig = "vec", desc = "\\vec{}" }, fmt("\\vec{{{}}}", { i(1) })),
  s({ trig = "hat", desc = "\\hat{}" }, fmt("\\hat{{{}}}", { i(1) })),
  s({ trig = "tilde", desc = "\\tilde{}" }, fmt("\\tilde{{{}}}", { i(1) })),
  s({ trig = "bar", desc = "\\bar{}" }, fmt("\\bar{{{}}}", { i(1) })),
  s({ trig = "dot", desc = "\\dot{}" }, fmt("\\dot{{{}}}", { i(1) })),
  s({ trig = "ddot", desc = "\\ddot{}" }, fmt("\\ddot{{{}}}", { i(1) })),

  s({ trig = "ovl", desc = "\\overline{}" }, fmt("\\overline{{{}}}", { i(1) })),
  s({ trig = "unl", desc = "\\underline{}" }, fmt("\\underline{{{}}}", { i(1) })),
  s({ trig = "ovb", desc = "\\overbrace{}" }, fmt("\\overbrace{{{}}}^{{{}}}", { i(1), i(2) })),
  s({ trig = "unb", desc = "\\underbrace{}" }, fmt("\\underbrace{{{}}}_{{{}}}", { i(1), i(2) })),

  -- Delimiters
  s({ trig = "lr(", desc = "\\left( \\right)" }, fmt("\\left( {} \\right)", { i(1) })),
  s({ trig = "lr[", desc = "\\left[ \\right]" }, fmt("\\left[ {} \\right]", { i(1) })),
  s({ trig = "lr{", desc = "\\left\\{ \\right\\}" }, fmt("\\left\\{{ {} \\right\\}}", { i(1) })),
  s({ trig = "lr|", desc = "\\left| \\right|" }, fmt("\\left| {} \\right|", { i(1) })),
  s({ trig = "lra", desc = "\\langle \\rangle" }, fmt("\\langle {} \\rangle", { i(1) })),
  s({ trig = "lrn", desc = "\\| \\| (norm)" }, fmt("\\left\\| {} \\right\\|", { i(1) })),

  -- Common sets / symbols
  s({ trig = "RR", desc = "\\mathbb{R}" }, t("\\mathbb{R}")),
  s({ trig = "NN", desc = "\\mathbb{N}" }, t("\\mathbb{N}")),
  s({ trig = "ZZ", desc = "\\mathbb{Z}" }, t("\\mathbb{Z}")),
  s({ trig = "QQ", desc = "\\mathbb{Q}" }, t("\\mathbb{Q}")),
  s({ trig = "CC", desc = "\\mathbb{C}" }, t("\\mathbb{C}")),
  s({ trig = "FF", desc = "\\mathbb{F}" }, t("\\mathbb{F}")),

  s({ trig = "mcal", desc = "\\mathcal{}" }, fmt("\\mathcal{{{}}}", { i(1) })),
  s({ trig = "mbb", desc = "\\mathbb{}" }, fmt("\\mathbb{{{}}}", { i(1) })),
  s({ trig = "mbf", desc = "\\mathbf{}" }, fmt("\\mathbf{{{}}}", { i(1) })),
  s({ trig = "mrm", desc = "\\mathrm{}" }, fmt("\\mathrm{{{}}}", { i(1) })),
  s({ trig = "mfk", desc = "\\mathfrak{}" }, fmt("\\mathfrak{{{}}}", { i(1) })),

  -- Operators
  s({ trig = "partial", desc = "\\partial" }, t("\\partial")),
  s({ trig = "nabla", desc = "\\nabla" }, t("\\nabla")),
  s({ trig = "inf", desc = "\\infty" }, t("\\infty")),
  s({ trig = "...", desc = "\\ldots" }, t("\\ldots")),
  s({ trig = "cdots", desc = "\\cdots" }, t("\\cdots")),
  s({ trig = "norm", desc = "\\| x \\| norm" }, fmt("\\| {} \\|", { i(1) })),
  s({ trig = "abs", desc = "| x | absolute value" }, fmt("| {} |", { i(1) })),

  s({ trig = "text", desc = "\\text{} in math mode" }, fmt("\\text{{{}}}", { i(1) })),

  s({ trig = "for", desc = "\\forall" }, t("\\forall")),
  s({ trig = "exs", desc = "\\exists" }, t("\\exists")),
  s({ trig = "in", desc = "\\in" }, t("\\in")),
  s({ trig = "sub", desc = "\\subset" }, t("\\subset")),
  s({ trig = "sube", desc = "\\subseteq" }, t("\\subseteq")),
  s({ trig = "emp", desc = "\\emptyset" }, t("\\emptyset")),
  s({ trig = "cup", desc = "\\cup" }, t("\\cup")),
  s({ trig = "cap", desc = "\\cap" }, t("\\cap")),
  s({ trig = "setm", desc = "\\setminus" }, t("\\setminus")),
  s({ trig = "to", desc = "\\to" }, t("\\to")),
  s({ trig = "iff", desc = "\\iff" }, t("\\iff")),
  s({ trig = "impl", desc = "\\implies" }, t("\\implies")),
  s({ trig = "land", desc = "\\land" }, t("\\land")),
  s({ trig = "lor", desc = "\\lor" }, t("\\lor")),
  s({ trig = "lnot", desc = "\\lnot" }, t("\\lnot")),
  s({ trig = "circ", desc = "\\circ (composition)" }, t("\\circ")),
  s({ trig = "times", desc = "\\times" }, t("\\times")),
  s({ trig = "cdot", desc = "\\cdot" }, t("\\cdot")),
  s({ trig = "neq", desc = "\\neq" }, t("\\neq")),
  s({ trig = "leq", desc = "\\leq" }, t("\\leq")),
  s({ trig = "geq", desc = "\\geq" }, t("\\geq")),
  s({ trig = "approx", desc = "\\approx" }, t("\\approx")),
  s({ trig = "sim", desc = "\\sim" }, t("\\sim")),
  s({ trig = "cong", desc = "\\cong" }, t("\\cong")),
  s({ trig = "equiv", desc = "\\equiv" }, t("\\equiv")),

  -- ---------------------------------------------------------------------------
  -- TEXT FORMATTING
  -- ---------------------------------------------------------------------------

  cmd("bf", "textbf", "bold text"),
  cmd("it", "textit", "italic text"),
  cmd("ul", "underline", "underlined text"),
  cmd("tt", "texttt", "monospace text"),
  cmd("sc", "textsc", "small caps"),
  cmd("emph", "emph", "emphasized text"),

  -- ---------------------------------------------------------------------------
  -- REFERENCES & CITATIONS
  -- ---------------------------------------------------------------------------

  s({ trig = "ref", desc = "\\ref{}" }, fmt("\\ref{{{}}}", { i(1) })),
  s({ trig = "eref", desc = "\\eqref{}" }, fmt("\\eqref{{{}}}", { i(1) })),
  s({ trig = "lbl", desc = "\\label{}" }, fmt("\\label{{{}}}", { i(1) })),
  s({ trig = "cref", desc = "cleveref \\cref{}" }, fmt("\\cref{{{}}}", { i(1) })),
  s({ trig = "Cref", desc = "cleveref \\Cref{}" }, fmt("\\Cref{{{}}}", { i(1) })),
  s({ trig = "cite", desc = "\\cite{}" }, fmt("\\cite{{{}}}", { i(1) })),
  s({ trig = "citep", desc = "\\citep{}" }, fmt("\\citep{{{}}}", { i(1) })),
  s({ trig = "citet", desc = "\\citet{}" }, fmt("\\citet{{{}}}", { i(1) })),
  s({ trig = "fn", desc = "\\footnote{}" }, fmt("\\footnote{{{}}}", { i(1) })),

  -- ---------------------------------------------------------------------------
  -- PACKAGES / PREAMBLE HELPERS
  -- ---------------------------------------------------------------------------

  s({ trig = "usepackage", desc = "\\usepackage{}" },
    fmt("\\usepackage{{{}}}", { i(1) })),

  s({ trig = "usepackageopt", desc = "\\usepackage[opts]{}" },
    fmt("\\usepackage[{}]{{{}}}", { i(1, "options"), i(2, "package") })),

  s({ trig = "newcmd", desc = "\\newcommand" },
    fmt("\\newcommand{{\\{}}}[{}]{{{}}}", { i(1, "name"), i(2, "0"), i(3, "definition") })),

  s({ trig = "renewcmd", desc = "\\renewcommand" },
    fmt("\\renewcommand{{\\{}}}[{}]{{{}}}", { i(1, "name"), i(2, "0"), i(3, "definition") })),

  s({ trig = "newenv", desc = "\\newenvironment" }, fmt([[
\newenvironment{{{}}}
  {{{}}}  % begin code
  {{{}}}  % end code
]], { i(1, "name"), i(2), i(3) })),

  -- ---------------------------------------------------------------------------
  -- TYPOGRAPHY / SPACING
  -- ---------------------------------------------------------------------------

  s({ trig = "hfill", desc = "\\hfill" }, t("\\hfill")),
  s({ trig = "vfill", desc = "\\vfill" }, t("\\vfill")),
  s({ trig = "hspace", desc = "\\hspace{}" }, fmt("\\hspace{{{}}}", { i(1, "1cm") })),
  s({ trig = "vspace", desc = "\\vspace{}" }, fmt("\\vspace{{{}}}", { i(1, "1cm") })),
  s({ trig = "noindent", desc = "\\noindent" }, t("\\noindent")),
  s({ trig = "nl", desc = "newline \\\\" }, t("\\\\")),
  s({ trig = "np", desc = "\\newpage" }, t("\\newpage")),

  -- ---------------------------------------------------------------------------
  -- MISC USEFUL
  -- ---------------------------------------------------------------------------

  s({ trig = "todo", desc = "TODO note (requires todonotes)" },
    fmt("\\todo{{{}}}", { i(1, "TODO") })),

  s({ trig = "href", desc = "\\href{url}{text}" },
    fmt("\\href{{{}}}{{{}}}", { i(1, "https://"), i(2, "text") })),

  s({ trig = "url", desc = "\\url{}" },
    fmt("\\url{{{}}}", { i(1) })),

  s({ trig = "incg", desc = "\\includegraphics" },
    fmt("\\includegraphics[width={}]{{{}}}", { i(1, "\\textwidth"), i(2, "filename") })),

  s({ trig = "biblio", desc = "bibliography commands" }, fmt([[
\bibliographystyle{{{}}}
\bibliography{{{}}}
]], { i(1, "plain"), i(2, "references") })),

  s({ trig = "printbib", desc = "biblatex \\printbibliography" },
    t("\\printbibliography")),

} -- end return
