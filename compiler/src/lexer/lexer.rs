use super::token::Token;
use super::keywords::c_keywords;

pub struct Lexer {
    pub input: Vec<char>,
    pub position: usize,
    pub line: usize,
    pub column: usize,
}

impl Lexer {
    pub fn new(input: &str) -> Self {
        Self { 
            input: input.chars().collect(), 
            position: 0,
            line: 1,
            column: 1,
        }
    }

    pub fn tokenize(&mut self) -> Result<Vec<Token>, String> {
        let mut tokens = Vec::new();
        
        while self.position < self.input.len() {
            self.skip_whitespace();
            
            if self.position >= self.input.len() {
                break;
            }
            
            let token = self.next_token()?;
            tokens.push(token);
        }
        
        tokens.push(Token::EOF);
        Ok(tokens)
    }

    fn skip_whitespace(&mut self) {
        while self.position < self.input.len() {
            let ch = self.input[self.position];
            match ch {
                ' ' | '\t' => {
                    self.position += 1;
                    self.column += 1;
                }
                '\n' => {
                    self.position += 1;
                    self.line += 1;
                    self.column = 1;
                }
                '\r' => {
                    self.position += 1;
                    if self.position < self.input.len() && self.input[self.position] == '\n' {
                        self.position += 1;
                    }
                    self.line += 1;
                    self.column = 1;
                }
                _ => break,
            }
        }
    }

    fn next_token(&mut self) -> Result<Token, String> {
        let ch = self.input[self.position];
        
        match ch {
            'a'..='z' | 'A'..='Z' | '_' => {
                self.read_identifier_or_keyword()
            }
            '0'..='9' => {
                self.read_number()
            }
            '+' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Plus)
            }
            '-' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Minus)
            }
            '*' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Multiply)
            }
            '/' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Divide)
            }
            '=' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Assign)
            }
            ';' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Semicolon)
            }
            ',' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::Comma)
            }
            '(' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::LeftParen)
            }
            ')' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::RightParen)
            }
            '{' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::LeftBrace)
            }
            '}' => {
                self.position += 1;
                self.column += 1;
                Ok(Token::RightBrace)
            }
            _ => {
                Err(format!("Unexpected character '{}' at line {}, column {}", 
                           ch, self.line, self.column))
            }
        }
    }

    fn read_identifier_or_keyword(&mut self) -> Result<Token, String> {
        let start = self.position;
        let start_column = self.column;
        
        while self.position < self.input.len() {
            let ch = self.input[self.position];
            if ch.is_alphanumeric() || ch == '_' {
                self.position += 1;
                self.column += 1;
            } else {
                break;
            }
        }
        
        let identifier: String = self.input[start..self.position].iter().collect();
        
        if c_keywords().contains(identifier.as_str()) {
            Ok(Token::Keyword(identifier))
        } else {
            Ok(Token::Identifier(identifier))
        }
    }

    fn read_number(&mut self) -> Result<Token, String> {
        let start = self.position;
        let start_column = self.column;
        
        while self.position < self.input.len() {
            let ch = self.input[self.position];
            if ch.is_digit(10) {
                self.position += 1;
                self.column += 1;
            } else {
                break;
            }
        }
        
        let number_str: String = self.input[start..self.position].iter().collect();
        match number_str.parse::<i64>() {
            Ok(num) => Ok(Token::IntegerLiteral(num)),
            Err(_) => Err(format!("Invalid number '{}' at line {}, column {}", 
                                 number_str, self.line, start_column))
        }
    }

    pub fn get_position_info(&self) -> (usize, usize) {
        (self.line, self.column)
    }
} 