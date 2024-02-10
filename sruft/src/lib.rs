uniffi::include_scaffolding!("sruft");

pub fn rust_add(left: u64, right: u64) -> u64 {
    left + right
}

pub fn rust_greeting(text: &str) -> String {
    format!("Hello {}, this is rust", text)
}
