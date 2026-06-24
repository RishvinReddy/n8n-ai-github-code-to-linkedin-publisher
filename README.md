# n8n AI GitHub Code to LinkedIn Publisher

![MIT License](https://img.shields.io/badge/License-MIT-green.svg)
![n8n](https://img.shields.io/badge/n8n-Workflow-ff6600.svg?logo=n8n)
![OpenRouter](https://img.shields.io/badge/AI-OpenRouter-blueviolet.svg)
![LinkedIn API](https://img.shields.io/badge/API-LinkedIn-0077b5.svg?logo=linkedin)
![GitHub API](https://img.shields.io/badge/API-GitHub-181717.svg?logo=github)
![Maintained](https://img.shields.io/badge/Maintained-Yes-success.svg)
![Version](https://img.shields.io/badge/Version-v1.0.0-blue.svg)

![n8n AI GitHub Code to LinkedIn Publisher Banner](assets/banner.png)

Automatically convert GitHub commits into AI-generated LinkedIn posts with syntax-highlighted code images using n8n, OpenRouter, GitHub, and LinkedIn.

Created by **Rishvin Reddy**

If this workflow helps you, consider starring the repository.

---

## Overview

This n8n workflow monitors your GitHub repositories for new commits, extracts the modified code, analyzes it using an AI model (OpenRouter), and generates an engaging, professional LinkedIn post complete with a syntax-highlighted image of the most important code snippet.

```mermaid
mindmap
  root((n8n Workflow))
    Triggers
      GitHub Webhook
      Push Events
    Data Extraction
      Code Diff
      File Filtering
    AI Processing
      OpenRouter
      Gemini / Claude
      Structured JSON
    Media Generation
      HCTI API
      Prism.js Syntax
      GitHub Hosting
    Publishing
      LinkedIn API
      Text + Image Post
```

## Why This Project?

Developers often build interesting projects but rarely share them consistently. This workflow bridges that gap by automatically transforming meaningful GitHub commits into professional LinkedIn posts, helping developers build a stronger technical presence with minimal effort.

## Demo

![Demo](assets/demo.gif)
*(Add a demo GIF here showing a code push resulting in a LinkedIn post)*

## Workflow Information

- **Version**: 1.0.0
- **n8n Version**: >= 1.100
- **Nodes**: 22
- **Integrations**: 5
- **AI Models**: OpenRouter Compatible (Gemini 2.5 Flash recommended)
- **License**: MIT
- **Author**: Rishvin Reddy

## Supported Integrations

| Service | Status |
| :--- | :---: |
| GitHub | ✅ |
| LinkedIn | ✅ |
| OpenRouter | ✅ |
| Gemini | ✅ |
| HCTI | ✅ |
| n8n | ✅ |

## Gallery

| Workflow Overview | GitHub Trigger |
| :---: | :---: |
| ![Workflow Canvas](screenshots/workflow-overview.png) | ![GitHub Trigger](screenshots/github-trigger.png) |

| Generated Post | Code Snippet |
| :---: | :---: |
| ![LinkedIn Post Mockup](screenshots/linkedin-post.png) | ![Syntax Highlighted Code](screenshots/generated-code-image.png) |


## Features

| Feature | Supported |
| :--- | :---: |
| GitHub Push Trigger | Yes |
| AI Content Generation | Yes |
| Code Snippet Extraction | Yes |
| Syntax Highlighting | Yes |
| LinkedIn Publishing | Yes |
| Multi-language Support | Yes |
| Commit Batching | Planned |
| Pull Request Events | Planned |
| Release Notes | Planned |

## Architecture

The system operates entirely within the n8n automation engine, communicating with external APIs to fetch data, generate AI content, render images, and publish the final result.

### 1. High-Level Flowchart

```mermaid
flowchart LR
    A[GitHub Push]
    -->B[Extract Modified Files]
    -->C[Download Source Code]
    -->D[OpenRouter AI]
    -->E[Structured Output]
    -->F[Generate HTML]
    -->G[Generate Code Image]
    -->H[Upload Image]
    -->I[Publish to LinkedIn]
```

### 2. Sequence Diagram

This sequence diagram illustrates the chronological execution of API calls and data handoffs.

```mermaid
sequenceDiagram
    participant GH as GitHub
    participant n8n as n8n Workflow
    participant AI as OpenRouter (LLM)
    participant HCTI as HCTI API
    participant LI as LinkedIn

    GH->>n8n: Webhook Trigger (Push Event)
    n8n->>n8n: Filter for allowed extensions
    n8n->>GH: Request raw file content
    GH-->>n8n: Return file content
    n8n->>AI: Send code & prompt
    AI-->>n8n: Return post copy & snippet (JSON)
    n8n->>n8n: Generate Syntax Highlighted HTML
    n8n->>HCTI: Send HTML for rendering
    HCTI-->>n8n: Return Image URL
    n8n->>n8n: Download Image Data
    n8n->>GH: Upload Image for Hosting
    GH-->>n8n: Return Image Storage URL
    n8n->>LI: Send Post Copy + Image URL
    LI-->>n8n: Confirm Published Post
```

### 3. State Machine Diagram

This diagram represents the state transitions of a code commit as it passes through the automation pipeline.

```mermaid
stateDiagram-v2
    [*] --> CommitPushed
    CommitPushed --> FilteringFiles
    
    FilteringFiles --> Ignored: Non-code file (e.g., README)
    Ignored --> [*]
    
    FilteringFiles --> ValidCode: Allowed extension (e.g., .js, .py)
    ValidCode --> DownloadingContent
    
    DownloadingContent --> AnalyzingCode
    AnalyzingCode --> GeneratingCopy
    AnalyzingCode --> ExtractingSnippet
    
    GeneratingCopy --> CompilingPost
    ExtractingSnippet --> RenderingImage
    
    RenderingImage --> StoringImage
    StoringImage --> CompilingPost
    
    CompilingPost --> Publishing
    Publishing --> Published
    Published --> [*]
```

## Deep Dive: AI Processing Pipeline

The core intelligence of this workflow lies in the LangChain Structured Output Parser inside n8n. It enforces a strict schema on the LLM to ensure reliable, parsable data for downstream nodes.

```mermaid
classDiagram
    class LinkedInContent {
      +String post_title
      +String post_content
      +String code_snippet
      +String code_language
      +String hashtags
      +Integer character_count
    }
    class OutputParser {
      +parse(LLM_Response) LinkedInContent
    }
    OutputParser ..> LinkedInContent : Validates against schema
```

## Supported Languages

The workflow automatically detects and syntax-highlights a wide variety of programming languages. While any text-based code file can be processed, the default filter includes standard modern languages.

```mermaid
pie title Supported Language Distribution
    "JavaScript/TypeScript" : 40
    "Python" : 25
    "Go/Rust" : 15
    "Java/C#" : 10
    "Terraform/Bicep" : 10
```

## Error Handling & Retry Strategies

To ensure maximum reliability, especially when dealing with rate-limited APIs, the workflow implements structural error handling.

```mermaid
flowchart TD
    A[API Node Execution] --> B{Success?}
    B -- Yes --> C[Continue Pipeline]
    B -- No --> D{Error Type}
    
    D -- Rate Limit / 429 --> E[Wait 60s & Retry]
    E --> A
    
    D -- Bad JSON format --> F[Fallback Prompt]
    F --> A
    
    D -- Fatal / 401 --> G[Halt & Alert User]
```

## Use Cases

- **Personal Branding:** Maintain an active, professional presence on LinkedIn without manual effort.
- **Developer Portfolios:** Automatically showcase your open-source contributions and side projects to recruiters and peers.
- **Team Updates:** Share technical updates and interesting snippets from your company's repositories directly to your corporate LinkedIn page.
- **Educational Content:** Create a steady stream of bite-sized code tutorials based on your daily commits.

## Data Flow & Security

The workflow relies on several external APIs. Data is passed securely using HTTPS, and no credentials are hardcoded within the workflow itself.

```mermaid
flowchart LR
    subgraph Local Context
        Config[n8n Credentials]
    end
    
    subgraph External Services
        GitHub[GitHub Repo]
        OpenRouter[LLM Provider]
        HCTI[Image Renderer]
        LinkedIn[Social Network]
    end
    
    Config -.-> |Auth Tokens| GitHub
    Config -.-> |Auth Tokens| OpenRouter
    Config -.-> |Auth Tokens| HCTI
    Config -.-> |Auth Tokens| LinkedIn
```

**Security Considerations:**
- Use dedicated API keys scoped with minimum privileges (e.g., GitHub tokens restricted only to necessary repositories).
- All AI processing occurs via OpenRouter; refer to your selected model's data privacy policies.
- Ensure your n8n instance is secured behind a firewall or authentication proxy if hosted publicly.

## Repository Structure

```text
.
├── workflow/
│   └── n8n-ai-github-code-to-linkedin-publisher.json
├── docs/
│   ├── architecture.md
│   ├── credentials.md
│   ├── customization.md
│   ├── setup.md
│   └── troubleshooting.md
├── screenshots/
│   ├── workflow-overview.png
│   ├── github-trigger.png
│   ├── linkedin-post.png
│   └── generated-code-image.png
├── assets/
│   ├── banner.png
│   └── logo.png
├── examples/
│   ├── mock-github-webhook.json
│   └── test-webhook.sh
├── README.md
├── CHANGELOG.md
├── LICENSE
└── .env.example
```

## Requirements

- **n8n**: Version `1.100` or higher
- **GitHub**: Account with Personal Access Token (Classic)
- **LinkedIn**: Developer App with "Share on LinkedIn" access
- **OpenRouter**: API Key for LLM access
- **HCTI**: Account for HTML-to-Image generation

## Getting Started

1. Clone this repository or download the latest release.
2. Review the detailed setup instructions in [docs/setup.md](docs/setup.md).
3. Import `workflow/n8n-ai-github-code-to-linkedin-publisher.json` into your n8n instance.
4. Set up the required credentials and configure the placeholder variables.

## Documentation

- [Setup Guide](docs/setup.md)
- [Architecture Details](docs/architecture.md)
- [Credentials Configuration](docs/credentials.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Customization](docs/customization.md)

## Future Plans

- [ ] Pull Request Support
- [ ] Commit Batching
- [ ] Multiple Images
- [ ] Markdown Parsing
- [ ] Repository Statistics
- [ ] Better Error Handling
- [ ] Retry Logic
- [ ] Docker Support
- [ ] Dev.to Publishing
- [ ] Medium Publishing
- [ ] Threads Integration
- [ ] X (Twitter) Integration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
