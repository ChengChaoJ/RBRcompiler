use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Token {
    Identifier(String),
    Keyword(String),
    IntegerLiteral(i64),
    Plus,
    Minus,
    Multiply,
    Divide,
    Assign,
    Semicolon,
    Comma,
    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,
    EOF,
}

impl Token {
    pub fn to_string(&self) -> String {
        match self {
            Token::Identifier(s) => format!("Identifier({})", s),
            Token::Keyword(s) => format!("Keyword({})", s),
            Token::IntegerLiteral(n) => format!("Integer({})", n),
            Token::Plus => "Plus".to_string(),
            Token::Minus => "Minus".to_string(),
            Token::Multiply => "Multiply".to_string(),
            Token::Divide => "Divide".to_string(),
            Token::Assign => "Assign".to_string(),
            Token::Semicolon => "Semicolon".to_string(),
            Token::Comma => "Comma".to_string(),
            Token::LeftParen => "LeftParen".to_string(),
            Token::RightParen => "RightParen".to_string(),
            Token::LeftBrace => "LeftBrace".to_string(),
            Token::RightBrace => "RightBrace".to_string(),
            Token::EOF => "EOF".to_string(),
        }
    }
} 