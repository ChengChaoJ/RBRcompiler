use super::ast::ASTNode;
use crate::lexer::token::Token;

pub struct Parser {
    pub tokens: Vec<Token>,
    pub current: usize,
}

impl Parser {
    pub fn new(tokens: Vec<Token>) -> Self {
        Self { tokens, current: 0 }
    }

    pub fn parse(&mut self) -> ASTNode {
        // TODO: implement real parsing
        ASTNode::Program(vec![ASTNode::Empty])
    }
} 