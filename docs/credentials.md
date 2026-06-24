# Credentials Configuration

To run this workflow, you need to set up several credentials in n8n.

## 1. GitHub
Used for triggering the workflow, downloading code, and storing the generated images.
1. In n8n, create a new **GitHub API** credential.
2. Provide your GitHub username and a Personal Access Token.
3. The token needs `repo` scope to read code and upload image files.

## 2. LinkedIn
Used for publishing the final post.
1. Follow n8n's official guide to create a **LinkedIn OAuth2** credential.
2. You will need to create an app in the LinkedIn Developer portal.
3. Ensure the app has the `w_member_social` permission to post on your behalf.
4. Note your **Person URN** (e.g., `urn:li:person:ABCDEF12345`) for the Post to LinkedIn node.

## 3. OpenRouter (AI)
Used for analyzing the code and writing the post.
1. Create an account at [OpenRouter](https://openrouter.ai/).
2. Generate an API Key.
3. In n8n, create a new **OpenRouter API** credential and paste the key.

## 4. HCTI (HTML/CSS to Image)
Used for converting the code snippet into a beautiful image.
1. Create an account at [HCTI](https://hcti.io/).
2. You will receive a User ID and an API Key.
3. In n8n, the HTTP Request node uses **Basic Auth**. Create a generic HTTP Basic Auth credential.
4. Set the **Username** to your HCTI User ID.
5. Set the **Password** to your HCTI API Key.
