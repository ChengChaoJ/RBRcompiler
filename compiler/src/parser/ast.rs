use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum ASTNode {
    // Program structure
    Program(Vec<ASTNode>),
    
    // Declarations
    VariableDeclaration {
        type_name: String,
        name: String,
        initializer: Option<Box<ASTNode>>,
    },
    FunctionDeclaration {
        return_type: String,
        name: String,
        parameters: Vec<ASTNode>,
        body: Box<ASTNode>,
    },
    Parameter {
        type_name: String,
        name: String,
    },
    
    // Statements
    Block(Vec<ASTNode>),
    ExpressionStatement(Box<ASTNode>),
    IfStatement {
        condition: Box<ASTNode>,
        then_branch: Box<ASTNode>,
        else_branch: Option<Box<ASTNode>>,
    },
    WhileStatement {
        condition: Box<ASTNode>,
        body: Box<ASTNode>,
    },
    ForStatement {
        init: Option<Box<ASTNode>>,
        condition: Option<Box<ASTNode>>,
        update: Option<Box<ASTNode>>,
        body: Box<ASTNode>,
    },
    ReturnStatement(Option<Box<ASTNode>>),
    
    // Expressions
    Identifier(String),
    IntegerLiteral(i64),
    BinaryExpression {
        operator: BinaryOperator,
        left: Box<ASTNode>,
        right: Box<ASTNode>,
    },
    UnaryExpression {
        operator: UnaryOperator, 
        operand: Box<ASTNode>,
    },
    AssignmentExpression {
        target: Box<ASTNode>,
        value: Box<ASTNode>,
    },
    FunctionCall {
        name: String,
        arguments: Vec<ASTNode>,
    },
    
    // Empty node for error recovery
    Empty,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum BinaryOperator {
    Add,        // +
    Subtract,   // -
    Multiply,   // *
    Divide,     // /
    Equal,      // = (simplified assignment as equality for now)
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum UnaryOperator {
    Plus,       // +
    Minus,      // -
} 