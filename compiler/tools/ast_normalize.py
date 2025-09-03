#!/usr/bin/env python3
import json, sys

DROP_FIELDS = {"id", "addr", "range", "loc", "parent", "prevDecl"}
CHILD_KEYS = ["inner", "children", "stmts", "declarations", "body"]


def normalize(node):
    if isinstance(node, dict):
        out = {}
        for k, v in node.items():
            if k in DROP_FIELDS:
                continue
            out[k] = normalize(v)
        for ck in CHILD_KEYS:
            if ck in out and isinstance(out[ck], list):
                out[ck] = sorted([normalize(x) for x in out[ck]], key=lambda x: json.dumps(x, sort_keys=True))
        return out
    elif isinstance(node, list):
        return [normalize(x) for x in node]
    else:
        return node

if __name__ == '__main__':
    data = json.load(sys.stdin)
    norm = normalize(data)
    json.dump(norm, sys.stdout, ensure_ascii=False) 