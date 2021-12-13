use bevy::{input::*, prelude::*};

use crate::AppState;

pub struct MainMenuPlugin;
impl Plugin for MainMenuPlugin {
    fn build(&self, app: &mut AppBuilder) {
        app
        .add_system_set(
            SystemSet::on_enter(AppState::MainMenu).with_system(display_main_menu.system()),
        )
        .add_system_set(SystemSet::on_update(AppState::MainMenu).with_system(handle_ui.system()));
    }
}

fn display_main_menu(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    // play button
    commands
        .spawn_bundle(ButtonBundle {
            style: Style {
                size: Size::new(Val::Px(150.0), Val::Px(65.0)),
                // center button
                margin: Rect::all(Val::Auto),
                // horizontally center child text
                justify_content: JustifyContent::Center,
                // vertically center child text
                align_items: AlignItems::Center,
                ..Default::default()
            },
            ..Default::default()
        })
        .with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Play",
                    TextStyle {
                        font: asset_server.load("../crates/bevy/assets/fonts/FiraSans-Bold.ttf"),
                        font_size: 40.0,
                        color: Color::rgb(0.9, 0.9, 0.9),
                    },
                    Default::default(),
                ),
                ..Default::default()
            });
        });

    // option button
    commands
        .spawn_bundle(ButtonBundle {
            style: Style {
                size: Size::new(Val::Px(150.0), Val::Px(65.0)),
                // center button
                margin: Rect::all(Val::Auto),
                // horizontally center child text
                justify_content: JustifyContent::Center,
                // vertically center child text
                align_items: AlignItems::Center,
                ..Default::default()
            },
            visible: Visible{is_visible: false, ..Default::default()},
            ..Default::default()
        })
        .insert(OptionsBtn)
        .with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Options",
                    TextStyle {
                        font: asset_server.load("../crates/bevy/assets/fonts/FiraSans-Bold.ttf"),
                        font_size: 40.0,
                        color: Color::rgb(0.9, 0.9, 0.9),
                    },
                    Default::default(),
                ),
                ..Default::default()
            });
        });
}

fn handle_ui(
    mut keys: ResMut<Input<KeyCode>>,
    //mut app_state: ResMut<State<AppState>>,
    mut play_btn: Query<&mut Visible, (With<PlayBtn>)>,
    //mut options_btn: Query<&mut Visible, (With<OptionsBtn>)>,
    mut selected: ResMut<Selected>
) {
    // force to main menu with escape
    /*
    if keys.just_pressed(KeyCode::Escape) {
        app_state.set(AppState::MainMenu).unwrap();
        keys.reset(KeyCode::Escape);
    }
    */

    if keys.just_pressed(KeyCode::Up) {
        println!("Up!");
        println!("{:#?}", play_btn.single_mut());
        let mut visible = play_btn.single_mut().expect("Found it!");
        visible.is_visible = true;
        
    };
    if keys.just_pressed(KeyCode::Down) {
        println!("Down!")
    };
}
