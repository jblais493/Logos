local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Function to create class-enabled snippets with multiple classnames
local function class_snippet(tag)
    return s({
        trig = tag .. "%.[%w%.%-]+",
        regTrig = true,
        hidden = true,
    }, {
        f(function(_, snip)
            local classNames = snip.trigger:match(tag .. "%.(.+)")
            classNames = classNames:gsub("%.", " ") -- Replace dots with spaces
            return string.format("<%s class=\"%s\">", tag, classNames)
        end, {}),
        t({"", "\t"}),
        i(1),
        t({"", string.format("</%s>", tag)}),
    })
end

return {
    -- Div with multiple classes
    class_snippet("div"),
    
    -- Basic div
    s("div", {
        t({"<div>", "\t"}), i(1), t({"", "</div>"})
    }),

    -- HTML boilerplate (unchanged)
    s("html5", {
        t({"<!DOCTYPE html>", "<html lang=\"en\">", "<head>", "\t<meta charset=\"UTF-8\">", "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">", "\t<title>"}), i(1, "Document"), t({"</title>", "</head>", "<body>", "\t"}), i(2), t({"", "</body>", "</html>"})
    }),

    -- Link with multiple classes
    class_snippet("a"),
    s("a", fmt("<a href=\"{}\">{}</a>", { i(1, "url"), i(2, "text") })),

    -- Image with multiple classes
    class_snippet("img"),
    s("img", fmt("<img src=\"{}\" alt=\"{}\">", { i(1, "src"), i(2, "alt text") })),

    -- Unordered List with multiple classes
    class_snippet("ul"),
    s("ul", {
        t({"<ul>", "\t<li>"}), i(1), t({"</li>", "\t<li>"}), i(2), t({"</li>", "</ul>"})
    }),

    -- Ordered List with multiple classes
    class_snippet("ol"),
    s("ol", {
        t({"<ol>", "\t<li>"}), i(1), t({"</li>", "\t<li>"}), i(2), t({"</li>", "</ol>"})
    }),

    -- Input with multiple classes
    class_snippet("input"),
    s("input", fmt("<input type=\"{}\" name=\"{}\" id=\"{}\">", { i(1, "text"), i(2, "name"), i(3, "id") })),

    -- Form with multiple classes
    class_snippet("form"),
    s("form", fmt(
        "<form action=\"{}\" method=\"{}\">\n\t{}\n</form>",
        { i(1, "action"), i(2, "post"), i(3, "form content") }
    )),

    -- Table with multiple classes
    class_snippet("table"),
    s("table", {
        t({"<table>", "\t<tr>", "\t\t<th>"}), i(1), t({"</th>", "\t\t<th>"}), i(2), t({"</th>", "\t</tr>", "\t<tr>", "\t\t<td>"}), i(3), t({"</td>", "\t\t<td>"}), i(4), t({"</td>", "\t</tr>", "</table>"})
    }),

    -- Comment (unchanged)
    s("comment", fmt("<!-- {} -->", { i(1) })),

    -- Paragraph with multiple classes
    class_snippet("p"),
    s("p", fmt("<p>{}</p>", { i(1) })),

    -- Span 
    class_snippet("span"),
    s("span", fmt("<span>{}</span>", { i(1) })),

    -- Headings with multiple classes
    class_snippet("h1"),
    class_snippet("h2"),
    class_snippet("h3"),
    class_snippet("h4"),
    class_snippet("h5"),
    class_snippet("h6"),
    s("h1", fmt("<h1>{}</h1>", { i(1) })),
    s("h2", fmt("<h2>{}</h2>", { i(1) })),
    s("h3", fmt("<h3>{}</h3>", { i(1) })),
    s("h4", fmt("<h4>{}</h4>", { i(1) })),
    s("h5", fmt("<h5>{}</h5>", { i(1) })),
    s("h6", fmt("<h6>{}</h6>", { i(1) })),
}
