use std::collections::HashMap;
 
#[derive(Default)]
pub struct RegisterAllocator {
    pub allocated: HashMap<String, String>,
} 