use clap::{Parser};

#[derive(Parser)]
#[clap(version = "1.0", author = "Benjamin Starostka J. <benjamin.starostka@gmail.com>")]
struct Opts {
    #[clap(short, long, default_value = "default.conf")]
    config: String,
    input: String,
    #[clap(short, long, parse(from_occurrences))]
    verbose: i32,
    #[clap(subcommand)]
    subcmd: SubCommand
}

#[derive(Parser)]
enum SubCommand {
    #[clap(version = "1.2", author = "Ben <benjamin.starostka@gmail.com>")]
    Test(Test)
}

/// A subcommand for controlling testing
#[derive(Parser)]
struct Test {
    /// Print debug info
    #[clap(short)]
    debug: bool
}


fn main() {
    let opts: Opts = Opts::parse();

    match opts.verbose {
        0 => println!("No verbose information"),
        1 => println!("Some verbose information"),
        2 => println!("Tons of verbose information"),
        _ => println!("Please stop...")
    }
    
    match opts.subcmd {
        SubCommand::Test(t) => {
            if t.debug {
                println!("Printing debug information...");
            } else {
                println!("Printing normally")
            }
        }
    }
}
    