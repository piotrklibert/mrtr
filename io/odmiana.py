from funcy import compose
import cssselect
from lxml import html

import requests as r
import sys

url = 'https://pl.wiktionary.org/wiki/{}'.format(sys.argv[1])

page_source = page = r.get(url).text

page = html.fromstring(page)
mian = page.cssselect("[title=mianownik]")[0]
row = mian_row = mian.getparent().getparent()
przypadki = [mian_row]
for i in range(6):
    row = row.getnext()
    przypadki.append(row)
t = html.tostring
emap = compose(list, map)

spans = []
if len(przypadki[0].cssselect("td")) > 3:
    for p in map(lambda p: (x for x in p.cssselect("td")[1:]), przypadki):
        out = []
        try:
            c = 0
            while True:
                td = next(p)
                out.append(td.text)
                # print(c, td. text)
                if c in [0, 3] and not td.attrib.get("colspan"):
                    td = next(p)
                c += 1
        except StopIteration:
            spans.append(out)
else:
    for p in przypadki:
        spans.append(emap(lambda t: t.text, p.cssselect("td")[1:]))


out = "[\n"
for s in spans:
    out += "\t["
    for i, p in enumerate(s):
        if i != 0:
            out += (", ")
        out += ('"' + p + '"')
    out += "],\n"
out = out[:-2] + "\n"
out += "]\n"
print(out)

# print(html.tostring(

# ))
