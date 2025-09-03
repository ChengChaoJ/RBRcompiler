use std::collections::HashSet;

pub fn c_keywords() -> HashSet<&'static str> {
    [
        "int",
        "float",
        "char",
        "void",
        "if",
        "else",
        "while",
        "for",
        "return",
    ]
    .into_iter()
    .collect()
} 