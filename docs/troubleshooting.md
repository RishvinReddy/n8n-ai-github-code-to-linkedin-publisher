# Troubleshooting

If the workflow fails, check these common issues:

## 1. No LinkedIn Post Appears
- Check the n8n execution log.
- Ensure the **Person URN** is correct. It must be in the format `urn:li:person:YOUR_ID`.
- Ensure your LinkedIn developer app has the correct permissions (`w_member_social`).

## 2. Image Generation Fails
- The HCTI API has a rate limit and a size limit.
- If the AI extracts a code snippet that is too long, the HTML might break the renderer. The prompt explicitly asks for 10-20 lines to prevent this.
- Ensure your HCTI Basic Auth credentials (Username = User ID, Password = API Key) are correct.

## 3. Workflow Doesn't Trigger
- Ensure the workflow is set to **Active**.
- Check if the GitHub Webhook was successfully created in your repository settings. n8n creates this automatically when the workflow is activated.
- Check the file filter. If you only pushed a `README.md` update, the workflow will intentionally stop.

## 4. AI Node Fails or Returns Bad JSON
- The workflow uses LangChain's Structured Output Parser.
- If using a smaller or less capable model, it might fail to return valid JSON. We highly recommend using **Gemini 2.5 Flash** or **Claude 3 Haiku** via OpenRouter.
