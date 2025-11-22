local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local tex = {}
tex.in_math = function()
        return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
        return not tex.in_math()
end

local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	});
end

return {
  s({trig="ls"}, {
	t({"\\begin{itemize}",
	"\t\\item "}), i(1), d(2, rec_ls, {}),
	t({"", "\\end{itemize}"}), i(0)
}),
	s(
		{ trig = ";i", snippetType = "autosnippet" },
		fmta(
			[[
    \item <>
  ]],
			{
				i(1),
			}
		)
	),

	s(
		{ trig = "dm", snippetType = "autosnippet" },
		fmta("\\[\n<>\n\\]", {
			i(1),
		})
	),

	s(
		{ trig = "mk", snippetType = "autosnippet" },
		fmta("$<>$", {
			i(1),
		})
	),

	s(
		{ trig = "sum", snippetType = "autosnippet", condition = tex.in_math },
		fmta(
			[[
    \sum_{<>}^{<>} <>
  ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),

	s(
		{ trig = "int", snippetType = "autosnippet", condition = tex.in_math },
		fmta(
			[[
    \int_{<>}^{<>} <> \,d<>
  ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
			}
		)
	),

	s(
		{ trig = ";al", snippetType = "autosnippet" },
		fmta("\\begin{align*}\n<>\n\\end{align*}", {
			i(1),
		})
	),

	s({ trig = "bb", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\mathbb{<>}", { i(1)})),

	s({ trig = "sq", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\sqrt{<>}", { i(1)})),

	s({ trig = "cl", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\mathcal{<>}", { i(1)})),

	s({ trig = "wh", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\widehat{<>}", { i(1)})),

	s({ trig = "ol", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\overline{<>}", { i(1)})),

	s({ trig = "ora", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\overrightarrow{<>}", { i(1)})),

	s({ trig = "ob", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\overbrace{<>}", { i(1)})),

	s({ trig = "ub", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\underbrace{<>}", { i(1)})),

  s({ trig = "([^%s/]+)^", regTrig = true, snippetType = "autosnippet", condition = tex.in_math },
  fmta("<>^{<>}", { f(function(_, snip) return snip.captures[1] end), i(1) })),

  s({ trig = "([^%s/]+)_", regTrig = true, snippetType = "autosnippet", condition = tex.in_math },
  fmta("<>_{<>}", { f(function(_, snip) return snip.captures[1] end), i(1) })),


	s({ trig = "xrr", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\xrightarrow[<>]{<>}", { i(1), i(2)})),

	s({ trig = "ff", snippetType = "autosnippet", condition = tex.in_math }, fmta("\\frac{<>}{<>}", { i(1), i(2)})),

  s(
    { trig = "beg", snippetType = "autosnippet" },
    fmta(
        "\\begin{<>}\n\t<>\n\\end{<>}",
        {
            i(1),
            i(2),
            rep(1),
        }
    )
),

  s(
    { trig = "([^%s=/]+)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", condition = tex.in_math },
    fmta(
        "\\frac{<>}{<>}",
        {
            f(function(_, snip) return snip.captures[1] end),
            i(1),
        }
    )
),

	s({ trig = ";p", snippetType = "autosnippet", condition = tex.in_math }, t("\\varphi")),

	s({ trig = "Rr", snippetType = "autosnippet", condition = tex.in_math }, t("\\Rightarrow")),

	s({ trig = "Lr", snippetType = "autosnippet", condition = tex.in_math }, t("\\Leftarrow")),

	s({ trig = "rr", snippetType = "autosnippet", condition = tex.in_math }, t("\\rightarrow")),

	s({ trig = "lr", snippetType = "autosnippet", condition = tex.in_math }, t("\\leftarrow")),
  
	s({ trig = "ex", snippetType = "autosnippet", condition = tex.in_math }, t("\\exists")),

	s({ trig = "fa", snippetType = "autosnippet", condition = tex.in_math }, t("\\forall")),

	s({ trig = "bu", snippetType = "autosnippet", condition = tex.in_math }, t("\\bigcup")),

	s({ trig = "ba", snippetType = "autosnippet" , condition = tex.in_math}, t("\\bigcap")),

	s({ trig = ">=", snippetType = "autosnippet" , condition = tex.in_math}, t("\\geq")),

	s({ trig = "<=", snippetType = "autosnippet", condition = tex.in_math}, t("\\leq")),

}
