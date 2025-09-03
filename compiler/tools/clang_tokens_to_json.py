#!/usr/bin/env python3
import json, sys, re

token_re = re.compile(r"^(?P<kind>\w+) '\S+' .*?\[(?P<line>\d+):(?P<col>\d+)\].*$")

def parse_dump(stream):
    result = []
    for line in stream:
        line = line.strip()
        if not line:
            continue
        m = token_re.match(line)
        if not m:
            # fallback: keep kind only
            parts = line.split(" ", 1)
            result.append({"kind": parts[0], "raw": line})
        else:
            result.append({
                "kind": m.group("kind"),
                "loc": {"line": int(m.group("line")), "column": int(m.group("col"))}
            })
    return result

if __name__ == '__main__':
    tokens = parse_dump(sys.stdin)
    json.dump(tokens, sys.stdout, ensure_ascii=False) 