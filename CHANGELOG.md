# Changelog

All notable changes to this project will be documented in this file.

## [v1.0.0] - 2026-06-25

### Initial release
- **GitHub Trigger**: Automatically triggers on pushes to your selected repository.
- **AI Content Generation**: Uses OpenRouter (Gemini 2.5 Flash recommended) to write engaging LinkedIn copy.
- **Code Snippet Extraction**: AI extracts the most interesting 10-20 lines from your modified files.
- **Syntax Highlighting**: Generates beautiful "Mac-window" style code snippet images using HTML/CSS.
- **Image Generation**: Uses HCTI API to convert the syntax-highlighted HTML into an image.
- **LinkedIn Publishing**: Automatically posts the generated text and image to your LinkedIn profile.
- **Multi-language Support**: Automatically adapts to and highlights syntax for Python, Java, TypeScript, Rust, Go, and more.
- **File Filtering**: Excludes configuration files (like `package.json`, `README.md`) and only processes source code changes.
