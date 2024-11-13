// Prevents additional console window on Windows in release, DO NOT REMOVE!!
// #![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

#![cfg_attr(
  all(not(debug_assertions), target_os = "windows"),
  windows_subsystem = "windows"
)]
use powershell_script::PsScriptBuilder;
use serde::{Deserialize, Serialize};
use serde_json;

mod tests;

#[derive(Debug, Serialize, Deserialize, Clone)]

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

#[allow(unused_must_use)]
#[tauri::command]
async fn install_all() {
  // let apps: Vec<App> = vec![json.chrome, json.teams, json.office, json.papercut, json.naplan];
  
  let installed_apps = apps_installed();
  // let chrome_app = &installed_apps[0];
  // let teams_app = &installed_apps[1];
  // let office_app = &installed_apps[2];
  // let papercut_app = &installed_apps[3];
  // let naplan_app = &installed_apps[4];

  // Spawn threads for each function and keep track of their handles
  if !installed_apps[2].installed {     
          Office().await;
  }

  if !installed_apps[0].installed {
          Chrome().await;
  }

  if !installed_apps[1].installed {
          Teams().await;
  }

  // if !installed_apps[4].installed {
  //         Naplan().await;
  // }

  if !installed_apps[3].installed {
          Papercut().await;
  }

}

#[allow(non_snake_case)]
#[tauri::command]
async fn Chrome() -> Option<String> {
  let run_script = include_str!("chrome.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(true)
      .print_commands(false)
      .build();
    let output = ps.run(run_script).unwrap().to_string();
    if output != ""{
      println!("{:?}", output);
      Some(output)
    } else {
      None
    }
}

#[allow(non_snake_case)]
#[tauri::command]
async fn Teams() -> Option<String> {
  let run_script = include_str!("teams.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(true)
      .hidden(true)
      .print_commands(false)
      .build();
    let output = ps.run(run_script).unwrap().to_string();
    if output != ""{
      println!("{:?}", output);
      Some(output)
    } else {
      None
    }
}

#[allow(non_snake_case)]
#[tauri::command]
async fn Office() -> Option<String> { 
  let run_script = include_str!("office.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(false)
      .hidden(true)
      .print_commands(false)
      .build();
    let output = ps.run(run_script).unwrap().to_string();
      if output != ""{
        println!("{:?}", output);
        Some(output)
      } else {
        None
      }
}

#[allow(non_snake_case)]
#[tauri::command]
async fn Papercut() -> Option<String> {
  let run_script = include_str!("papercut.ps1");
      let ps = PsScriptBuilder::new()
      .no_profile(true)
      .non_interactive(false)
      .hidden(true)
      .print_commands(false)
      .build();
    let output = ps.run(run_script).unwrap().to_string();
    if output != ""{
      println!("{:?}", output);
      Some(output)
    } else {
      None
    }
}

#[allow(non_snake_case)]
#[tauri::command]
async fn Naplan() -> Option<String> {
  let run_script = include_str!("naplan.ps1");
  let ps = PsScriptBuilder::new()
    .no_profile(true)
    .non_interactive(true)
    .hidden(true)
    .print_commands(false)
    .build();
  let output = ps.run(run_script).unwrap().to_string();
  if output != ""{
    println!("{:?}", output);
    Some(output)
  } else {
    None
  }
}

#[tauri::command]
fn apps_installed() -> Vec<App> {
  let run_script = include_str!("Apps-Installed.ps1");
  //let ps_command = "-App chrome";
  let ps = PsScriptBuilder::new()
    .no_profile(true)
    .non_interactive(true)
    .hidden(true)
    .print_commands(true)
    .build();
  let output = ps.run(run_script).unwrap().to_string();

  let json: InstalledApps = serde_json::from_str(&output).unwrap();
  println!("{:?}", json);
  let apps: Vec<App> = vec![json.chrome, json.teams, json.office, json.papercut];
  apps
}

