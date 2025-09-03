use crate::ir::function::IRFunction;

pub struct RiscvCodegen;

impl RiscvCodegen {
    pub fn generate(_funcs: &[IRFunction]) -> String {
        // TODO: actual codegen
        String::from("    ret")
    }
} 