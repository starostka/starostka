echo "Running init" &&

[ ! -d ".submodules" ] &&
mkdir crates &&
git clone https://github.com/bevyengine/bevy.git ./crates &&
cd .submodules/bevy &&
git checkout latest