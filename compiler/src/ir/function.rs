use super::basic_block::BasicBlock;
 
#[derive(Debug, Clone)]
pub struct IRFunction {
    pub name: String,
    pub blocks: Vec<BasicBlock>,
} 