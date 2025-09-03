#[derive(Debug, Clone)]
pub enum ASTNode {
    Program(Vec<ASTNode>),
    Empty,
} 