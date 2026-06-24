# Architecture

The **n8n AI GitHub Code to LinkedIn Publisher** uses a modern API-driven architecture entirely orchestrated within n8n.

## Pipeline Overview

1. **Trigger Phase (GitHub)**
   - The workflow listens for a Webhook event fired by GitHub upon a `push`.
   - The `Extract Modified Files` node parses the `head_commit` payload to identify added and modified files.
   - It filters out non-code files (like `README.md`, `package-lock.json`, images) and only proceeds if relevant code files exist.

2. **Fetching Phase (GitHub)**
   - The `GitHub File Download` node utilizes the GitHub API to download the raw contents of the modified files.

3. **Analysis Phase (OpenRouter AI)**
   - The code content is passed to the `LinkedIn Content Creator` AI Agent.
   - Using **Gemini 2.5 Flash** (via OpenRouter), the LLM reads the code and returns a structured JSON object containing:
     - The LinkedIn post copy.
     - Extracted code snippet (10-20 lines).
     - Programming language detected.
     - Relevant hashtags.

4. **Image Generation Phase (HCTI)**
   - The `Create Code HTML` node takes the AI's extracted code snippet and dynamically generates an HTML file. This HTML uses CSS and Prism.js to style the code into a modern "Mac-window" UI.
   - The `Generate Code Image` node sends this HTML to the **HTML/CSS to Image (HCTI)** API, which renders it and returns an image URL.
   - A subsequent `HTTP Request` node downloads the actual binary image data.

5. **Storage Phase (GitHub)**
   - The `Upload to Image Repo` node commits the binary image back to a designated GitHub repository for hosting. (This is necessary because LinkedIn requires an image asset when posting).

6. **Publishing Phase (LinkedIn)**
   - Finally, the `Post to LinkedIn` node combines the AI-generated text, hashtags, the GitHub commit URL, and the generated image, and publishes them as an Image Post on your LinkedIn profile.
