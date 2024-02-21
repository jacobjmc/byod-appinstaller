// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use powershell_script::PsScriptBuilder;
use serde::{Deserialize, Serialize};
use serde_json;

#[derive(Debug, Serialize, Deserialize)]
struct App {
  name: String,
  installed: bool,
}
#[derive(Debug, Serialize, Deserialize)]
struct InstalledApps {
  chrome: App,
  teams: App,
  office: App,
}

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
fn apps_installed() -> InstalledApps {
    let run_script = include_str!("Apps-Installed.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(false)
      .print_commands(false)
      .build();
  let output = ps.run(run_script).unwrap().to_string();

  let json: InstalledApps = serde_json::from_str(&output).unwrap();
  println!("{:?}", json);

  InstalledApps {
    chrome: json.chrome,
    teams: json.teams,
    office: json.office,
  }
}