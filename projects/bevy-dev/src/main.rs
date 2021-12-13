use bevy::{
    input::{keyboard::KeyCode, Input},
    prelude::*, reflect::GetPath, utils::tracing::instrument::WithSubscriber,
};


mod player;
use player::*;

mod main_menu;
use main_menu::*;

// current app state (set default to MainMenu)
#[derive(Debug, Clone, Eq, PartialEq, Hash)]
enum AppState {
    MainMenu,
    InGame,
    Paused,
}
impl Default for AppState {
    fn default() -> Self {AppState::MainMenu}
}

// refer to this resource for global configurations
#[derive(Default, Debug)]
struct GlobalState{
    state: AppState
}

fn main() {
    App::build()
        .add_plugins(DefaultPlugins)
        //.init_resource::<GlobalState>()
        .add_state(AppState::MainMenu)
        //.add_plugin(PlayerPlugin)
        .add_plugin(MainMenuPlugin)
        .add_startup_system(setup.system())
        //.add_system_set(
        //    SystemSet::on_enter(AppState::InGame).with_system(display_game.system())
        //)
        // .add_startup_system(startup.system())
        // .add_system(play.system())
        .run();
}

fn setup(mut commands: Commands, asset_server: Res<AssetServer>, mut app_state: ResMut<State<AppState>>) {

    println!("> Setup Reached");

    // UI Camera
    commands
    .spawn_bundle(UiCameraBundle::default())
    .spawn_bundle(UiCameraBundle::default());

}