// macros3.rs
//
// Make me compile, without taking the macro out of the module!
//
// Execute `rustlings hint macros3` or use the `hint` watch subcommand for a
// hint.

mod macros {
    macro_rules! my_macro {
        () => {
            println!("Check out my macro!");
        };
    }

    // Re-export the macro so it can be used outside of the module
    pub(crate) use my_macro;
}

fn main() {
    // Call the macro with its module path
    macros::my_macro!();
}
