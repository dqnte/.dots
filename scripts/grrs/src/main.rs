#![allow(unused)]

use anyhow::{Context, Result}; // Result struct wrapper
use clap::Parser; // Cli struct wrapper with helpful default
use std::cmp;
use std::fs;
use termsize; // finds the number of columns in the terminal

static MIN_LEN: usize = 16; // minimum column length
static DELIMITER: &str = "----"; // splits dirs and files
static LEFT_PADDING: &str = "  ";

#[derive(Parser)]
struct Cli {
    #[arg(short, long)] // defines a flag (-a, --all)
    all: bool,
    #[arg(default_value_t = (".".to_string()))]
    path: String,
}

fn format_group(mut list: Vec<String>, column_len: usize, num_cols: usize) -> Result<String> {
    if list.len() == 0 {
        return Ok("".to_string());
    }
    let mut group = "\n".to_string();
    let mut current_col = 1;

    // list must be mutable because it is sorted
    list.sort();

    for name in list {
        if current_col > num_cols {
            current_col = 1;
            group.push_str("\n");
        }
        if current_col == 1 {
            group.push_str(LEFT_PADDING)
        }

        // format can pad the string for us given a min length
        let padded = format!("{:<1$}  ", &name, column_len);
        group.push_str(&padded);

        current_col = current_col + 1;
    }

    Ok(group)
}

fn find_column_len(list: Vec<String>) -> Result<(usize, usize)> {
    let termsize::Size { rows, cols } = termsize::get().unwrap();

    // there's probably a better way to do this
    let mut longest_len = 0;
    for name in list {
        if longest_len < name.len() {
            longest_len = name.len();
        }
    }

    longest_len = cmp::max(longest_len, MIN_LEN);

    // casting col as usize since it's actual type is u16
    let num_cols = (cols as usize - 2 * LEFT_PADDING.len()) / (longest_len + 2);
    Ok((longest_len, num_cols))
}

// Finds files and directories in CWD and prints them similar to ls
fn main() -> Result<()> {
    // using clap parser methods
    let args = Cli::parse();

    let ls_path = args.path;

    // unwrap is shorthand for unwrapping the Result struct
    let items = fs::read_dir(ls_path).unwrap();

    // arrays in rust have a fixed length, you cannot append
    // let files: [&str; 10] = some array of strings of length 10

    // vectors behave more like lists in python
    let mut files = Vec::new();
    let mut dirs = Vec::new();

    for item in items {
        // unwrap seems to modify the item so you can't unwrap twice
        let path = item.unwrap().path();
        let file_name = path.file_name().unwrap().to_str().unwrap().to_string();

        if file_name.starts_with('.') && !args.all {
            continue;
        }

        // cloning the value here lets you pass it to the new function.
        // if you don't clone it, the value gets removed from the memory
        // of this function so it can't be used later.
        if path.is_dir() {
            dirs.push(format!("{}/", file_name.clone()));
        }

        if path.is_file() {
            files.push(file_name.clone());
        }
    }

    // extend adds the elements of the given vector to the vector it's called with
    let mut all_names = vec![];
    all_names.extend(dirs.clone());
    all_names.extend(files.clone());

    // unpacking tuple values
    let (column_len, num_cols) = find_column_len(all_names)?;

    // question mark added at end of function call in case function results in error
    let dir_string = format_group(dirs, column_len, num_cols)?;
    let file_string = format_group(files, column_len, num_cols)?;

    // using println! requires is much less performant than writing to a buffer then
    // printing all at once
    print!(
        "{}\n{padding}{delimiter}{}\n\n",
        dir_string,
        file_string,
        delimiter = DELIMITER,
        padding = LEFT_PADDING
    );

    // last execution call is returned by default so this returns empty Result
    Ok(())
}
