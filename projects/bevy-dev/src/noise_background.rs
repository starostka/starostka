
use bevy::prelude::*;
use noise::{utils::*, Perlin, Seedable};

pub struct NoiseBackgroundPlugin;
impl Plugin for NoiseBackgroundPlugin {
    fn build(&self, app:&mut AppBuilder ) {
        //app.
    }
}

fn generate_perlin_noise() {

    // perhaps adjust the seed every 10'th second to update pattern
    todo!("chose size of perlin noise based on window size");

    let perlin = Perlin::default();
    PlaneMapBuilder::new(perlin)
        .set_size(1024,1024)
        .set_x_bounds(-5.0, 5.0)
        .set_y_bounds(-5.0, 5.0)
        .build()
}

// adjust how points should look like
struct PointMaterialResource {
    color: Handle<ColorMaterial>
}
impl FromResource for PointMaterialResource {
    fn from_resources(resources: &Resources) -> Self {
        let mut materials = resources.get_mut::<Assets<ColorMaterial>>().unwrap();
        let asset_server = resources.get::<AssetServer>().unwrap();
    }
}

fn init_background( ) {
    
}

fn animate_background() {
    
}