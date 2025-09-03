use std::collections::HashMap;
 
#[derive(Default)]
pub struct SymbolTable {
    pub symbols: HashMap<String, String>,
} 