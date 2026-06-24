# Customization

You can easily adapt this workflow to fit your exact needs.

## Modifying the AI Prompt
To change the tone or structure of the LinkedIn post:
1. Open the **LinkedIn Content Creator** node.
2. Edit the System Message in the options.
3. For example, you can tell the AI to "Write in the style of a pirate" or "Focus strictly on security implications."

## Changing the Image Styling
The image is generated using standard HTML and CSS inside the **Create Code HTML** code node.
1. Open the Code node.
2. Modify the CSS inside the `<style>` block.
3. You can change the background gradient, the font, the padding, or the colors of the "Mac window" dots.
4. Prism.js is used for syntax highlighting. You can swap the theme by changing the CDN link to a different Prism theme (e.g., `prism-okaidia.css`).

## Adding More File Types
If you use a language that is not currently filtered:
1. Open the **Extract Modified Files** code node.
2. Add your extension to the `allowedExtensions` array.
3. Example: `allowedExtensions.push('.php', '.rb');`
