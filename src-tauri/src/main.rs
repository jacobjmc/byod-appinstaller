// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use powershell_script::PsScriptBuilder;



fn main() {
  tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![script, apps_installed])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}

#[tauri::command]
fn script() {
  let run_script = include_str!("script.ps1");
    match powershell_script::run(run_script) {
        Ok(output) => {
            println!("{}", output);
        }
        Err(e) => {
            println!("Error: {}", e);
        }
    }
}

#[tauri::command]
fn apps_installed() -> String {
  let run_script = include_str!("Apps-Installed.ps1");
    let ps = PsScriptBuilder::new()
    .no_profile(true)
    .non_interactive(true)
    .hidden(false)
    .print_commands(false)
    .build();
let output = ps.run(run_script).unwrap();

println!("{}", output);
output.to_string()
}