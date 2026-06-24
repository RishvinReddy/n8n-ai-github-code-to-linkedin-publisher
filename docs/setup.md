# Setup Guide

Follow these steps to import and configure the **n8n AI GitHub Code to LinkedIn Publisher** workflow.

## 1. Import the Workflow

1. Open your n8n workspace.
2. Click on **Add Workflow**.
3. In the top right corner, click on the **Import from file...** option.
4. Select the `workflow/n8n-ai-github-code-to-linkedin-publisher.json` file from this repository.
5. Save the workflow.

## 2. Configure Credentials

Before activating the workflow, you must set up the necessary credentials in n8n:
- **GitHub API** (for triggering and file access)
- **LinkedIn API** (for publishing posts)
- **OpenRouter API** (for AI content generation)
- **HCTI API** (for generating the code snippet image)

For detailed instructions on obtaining these API keys and setting them up in n8n, please see the [Credentials Guide](credentials.md).

## 3. Configure Node Placeholders

Once your credentials are created, you must assign them to the relevant nodes and update the placeholder variables in the workflow:

1. **GitHub Trigger Node**: Select your GitHub credential. Update `owner` to your GitHub username and `repository` to the source repo.
2. **GitHub File Download Node**: Select your GitHub credential. Update `owner` and `repository`.
3. **LinkedIn Content Creator (AI Node)**: Select your OpenRouter credential.
4. **Generate Code Image (HCTI Node)**: Select your HCTI basic auth credential.
5. **Upload to Image Repo (GitHub Node)**: Select your GitHub credential. Update `owner` and `repository` (this should be the repository where you want images to be stored).
6. **Post to LinkedIn Node**: Select your LinkedIn credential. Update the `person` URN field.

## 4. Test the Workflow

1. Click **Test Workflow** in n8n.
2. Push a code change to your target GitHub repository.
3. Watch the workflow execute step-by-step.
4. Verify that an image was uploaded to your image repository and that a post appeared on your LinkedIn profile.

## 5. Activate

Once testing is successful, toggle the workflow from **Inactive** to **Active**.
