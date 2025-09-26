use std::fs;
use clap::{Parser, ValueEnum};
use anyhow::{Result, Context, Error};
use serde_json;
use std::path::Path;

mod lexer;
mod parser;
mod semantic;
mod bisheng;
mod ir;
mod riscv;
mod error;
mod utils;

#[derive(Parser)]
#[command(name = "rbr-compiler")]
#[command(about = "A C language compiler written in Rust")]
struct Cli {
    /// Input C source file
    #[arg(value_name = "FILE")]
    file: String,

    /// Output format (token 输出格式)
    #[arg(short, long, value_enum, default_value_t = OutputFormat::Text)]
    format: OutputFormat,

    /// Output file (token 输出，默认 stdout)
    #[arg(short, long)]
    output: Option<String>,

    /// AST 输出文件（可选，指定则会输出 AST 到该文件）
    #[arg(long)]
    ast_output: Option<String>,
}

#[derive(ValueEnum, Clone)]
enum OutputFormat {
    Text,
    Json,
}

fn main() -> Result<()> {
    let cli = Cli::parse();

    // Read input file
    let source_code = fs::read_to_string(&cli.file)
        .with_context(|| format!("Failed to read file: {}", cli.file))?;

    // Create lexer and tokenize
    let mut lexer = lexer::lexer::Lexer::new(&source_code);
    let tokens = lexer
        .tokenize()
        .map_err(|e| Error::msg(e))?;

    // 如果指定 ast_output，则直接输出 AST 到文件
    if let Some(ast_path) = cli.ast_output {
        let mut parser = parser::parser::Parser::new(tokens);
        let ast = parser.parse().map_err(|e| Error::msg(e))?;
        fs::write(&ast_path, format!("{:#?}", ast))
            .with_context(|| format!("Failed to write AST file: {}", ast_path))?;
        println!("AST written to: {}", ast_path);
        return Ok(());
    }

    // Output tokens
    let output = match cli.format {
        OutputFormat::Text => {
            tokens.iter()
                .map(|token| token.to_string())
                .collect::<Vec<String>>()
                .join("\n")
        }
        OutputFormat::Json => {
            serde_json::to_string_pretty(&tokens)
                .with_context(|| "Failed to serialize tokens to JSON")?
        }
    };

    // Write output
    if let Some(output_file) = cli.output {
        fs::write(&output_file, output)
            .with_context(|| format!("Failed to write output file: {}", output_file))?;
        println!("Tokens written to: {}", output_file);
    } else {
        println!("{}", output);
    }

    Ok(())
}