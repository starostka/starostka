use bevy::prelude::*;

// plugin stuff
pub struct PlayerPlugin;
impl Plugin for PlayerPlugin {
    fn build(&self, app: &mut AppBuilder) {
        app.add_system(player_input.system())
            .add_system(player_collision.system());
    }
}


// entity, components and systems related to player
struct Name(String);
struct Health(pub u8);

pub struct Player;
struct Character {
    health: Health,
    player_type: Player
}

struct Enemy;
struct Devil {
    health: Health,
    player_type: Enemy
}

fn player_input() {}

fn player_collision() {}

fn display_players(query: Query<&Name, With<Player>>) {
    for name in query.iter() {
        println!("Hello {}", name.0);
    }
}
