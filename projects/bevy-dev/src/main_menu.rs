use bevy::{input::*, prelude::*};
use rotate_enum::RotateEnum;

use crate::AppState;

pub struct MainMenuPlugin;
impl Plugin for MainMenuPlugin {
    fn build(&self, app: &mut AppBuilder) {
        app
        .init_resource::<MenuState>()
        .add_system_set(
            SystemSet::on_enter(AppState::MainMenu).with_system(display_main_menu.system()),
        )
        .add_system_set(SystemSet::on_update(AppState::MainMenu).with_system(handle_ui.system()))
        .add_system(update_menu.system());
    }
}

#[derive(Debug, RotateEnum, PartialEq)]
enum Buttons {PLAY, OPTIONS, EXIT}
impl Default for Buttons {
    fn default() -> Self {Buttons::PLAY}
}
#[derive(Default, Debug)]
struct MenuState{
    selected: Buttons,
}

// constants
const SELECTED_SIZE: f32 = 60.0;

fn display_main_menu(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    // play button
    commands
        .spawn_bundle(NodeBundle {
            ..Default::default()
        }).with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Play",
                    TextStyle { font: asset_server.load("../assets/fonts/nasalization-rg.otf"), font_size: 40.0, color: Color::BLACK },
                    Default::default()
                ),
                ..Default::default()  
            }).insert(Buttons::PLAY);

            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Options",
                    TextStyle { font: asset_server.load("../assets/fonts/nasalization-rg.otf"), font_size: 40.0, color: Color::BLACK},
                    Default::default()
                ),
                ..Default::default()
            }).insert(Buttons::OPTIONS);

            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Exit",
                    TextStyle { font: asset_server.load("../assets/fonts/nasalization-rg.otf"), font_size: 40.0, color: Color::BLACK},
                    Default::default()
                ),
                ..Default::default()
            }).insert(Buttons::EXIT);
        });
}

// update menu upon selects
fn update_menu(
    mut query: Query<(&mut Text, &Buttons), With<Buttons>>,
    res: Res<MenuState>
) {
    if res.is_changed() {
        for (mut q, btn) in query.iter_mut() {
            if res.selected == *btn {
                q.sections[0].style.font_size = SELECTED_SIZE;
            }
            q.sections[0].style.font_size = 40.0;
        }
    }
}

// perform changes
fn handle_ui(
    mut keys: ResMut<Input<KeyCode>>,
    mut menu_state: ResMut<MenuState>,
) {
    // force to main menu with escape

    if keys.just_pressed(KeyCode::Up) {
        let i = (menu_state.selected + 1) % 3;
        menu_state.selected = Buttons::PLAY;
        println!("{:#?}", menu_state.selected);
    }

    if keys.just_pressed(KeyCode::Down) {
        menu_state.selected = Buttons::OPTIONS;
        println!("{:#?}", menu_state.selected);
    }
}
