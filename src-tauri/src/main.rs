// Prevents additional console window on Windows in release, DO NOT REMOVE!!
// #![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

#![cfg_attr(
  all(not(debug_assertions), target_os = "windows"),
  windows_subsystem = "windows"
)]

use powershell_script::PsScriptBuilder;
use serde::{Deserialize, Serialize};
use serde_json;

#[derive(Debug, Serialize, Deserialize)]

struct App {
  name: String,
  installed: bool,
  image: String,
}
#[derive(Debug, Serialize, Deserialize)]
struct InstalledApps {
  chrome: App,
  teams: App,
  office: App,
  papercut: App,
  naplan: App,
}

fn main() {
  tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![install_all, Chrome, Teams, Office, Papercut, Naplan, apps_installed])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}

#[tauri::command]
fn install_all() {
  Office();
  Chrome();
  Teams();
  Naplan();
  Papercut();
}

#[allow(non_snake_case)]
#[tauri::command]
fn Chrome() {
  let run_script = include_str!("chrome.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(true)
      .print_commands(false)
      .build();
    ps.run(run_script).unwrap().to_string();
}

#[allow(non_snake_case)]
#[tauri::command]
fn Teams() {
  let run_script = include_str!("teams.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(true)
      .print_commands(false)
      .build();
    ps.run(run_script).unwrap().to_string();
}

#[allow(non_snake_case)]
#[tauri::command]
fn Office() {
  let run_script = include_str!("office.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(false)
      .hidden(true)
      .print_commands(false)
      .build();
    ps.run(run_script).unwrap().to_string();
}

#[allow(non_snake_case)]
#[tauri::command]
fn Papercut() {
  let run_script = include_str!("papercut.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(false)
      .hidden(true)
      .print_commands(false)
      .build();
    ps.run(run_script).unwrap().to_string();
}

#[allow(non_snake_case)]
#[tauri::command]
fn Naplan() {
  let run_script = include_str!("naplan.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(true)
      .print_commands(false)
      .build();
    ps.run(run_script).unwrap().to_string();
}

#[tauri::command]
fn apps_installed() -> Vec<App> {
    let run_script = include_str!("Apps-Installed.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(true)
      .print_commands(false)
      .build();
  let output = ps.run(run_script).unwrap().to_string();

  let json: InstalledApps = serde_json::from_str(&output).unwrap();
  println!("{:?}", json);

  let apps: Vec<App> = vec![json.chrome, json.teams, json.office, json.papercut, json.naplan];
  apps
}