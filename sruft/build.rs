use std::process::Command;

use uniffi_bindgen::{bindings::TargetLanguage, generate_bindings};

fn main() {
    let udl_file = "./src/sruft.udl";
    let out_dir = "./bindings/";
    uniffi_build::generate_scaffolding(udl_file).unwrap();
    let target_languages = vec![TargetLanguage::Swift, TargetLanguage::Kotlin, TargetLanguage::Python];
    generate_bindings(
        udl_file.into(),
        None,
        target_languages,
        Some(out_dir.into()),
        None,
        Some("sruft"),
        true,
    ).unwrap();
    // generate_bindings(
    //     udl_file.into(),
    //     None,
    //     target_languages,
    //     Some(out_dir.into()),
    //     None,
    //     true,
    // )
    // .unwrap();
}
