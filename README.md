# n8n AI GitHub Code to LinkedIn Publisher

Automatically transform GitHub commits into AI-generated LinkedIn posts with beautiful code images using n8n, OpenRouter, GitHub, and LinkedIn.

Created by **Rishvin Reddy**

If this workflow helps you, consider starring the repository.

---

## Overview

This n8n workflow monitors your GitHub repositories for new commits, extracts the modified code, analyzes it using an AI model (OpenRouter), and generates an engaging, professional LinkedIn post complete with a syntax-highlighted image of the most important code snippet.

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
graph TD
    A[GitHub Push Event] --> B{Filter Changed Files}
    B -- Valid Code Files --> C[Download Raw File Content via GitHub API]
    B -- Ignored Files --> D[Halt Workflow]
    
    C --> E[AI Analysis via OpenRouter]
    E -->|Structured Output| F[Extract 10-20 Lines & Generate Copy]
    
    F --> G[Generate HTML/CSS 'Mac-window' code block]
    G --> H[Convert HTML to Image via HCTI API]
    
    H --> I[Upload Image to GitHub Storage Repo]
    I --> J[Compile LinkedIn Post]
    
    J --> K[Publish to LinkedIn via API]
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

## Roadmap

- [ ] Commit batching
- [ ] PR support
- [ ] Release notes
- [ ] Multi-image carousel

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
