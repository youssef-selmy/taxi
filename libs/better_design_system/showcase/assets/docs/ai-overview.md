# AI Assistant Overview

The BetterSuite MCP Server provides AI assistants with structured access to the entire design system. Using the Model Context Protocol (MCP), your AI coding assistant can search components, understand properties, generate usage examples, and ensure design system compliance.

---

## What Can It Do?

With the MCP Server installed, your AI assistant gains superpowers:

| Capability | Description |
|------------|-------------|
| [Figma to Flutter](figma-to-flutter) | Convert Figma designs directly to Flutter code |
| [Build UI with AI](build-ui-with-ai) | Create screens using natural language |
| [Theme Generation](theme-generation) | Generate complete themes from colors or vibes |

---

## Installation

### macOS / Linux

Run the following command in your terminal, replacing `YOUR_LICENSE_CODE` with your CodeCanyon purchase code:

```bash
curl -sSL https://uploads.bettersuite.io/mcp-update.sh | bash -s -- YOUR_LICENSE_CODE
```

### Windows (PowerShell)

Run the following command in PowerShell as Administrator:

```powershell
irm https://uploads.bettersuite.io/mcp-update.ps1 | iex; Install-BetterMCP YOUR_LICENSE_CODE
```

### What the installer does

1. Detects your platform automatically
2. Downloads the correct binary to `~/.local/bin/better-mcp`
3. Stores your license in `~/.config/better-mcp/.license`
4. Makes the binary executable

### Supported Platforms

| Platform | Architecture          |
| -------- | --------------------- |
| macOS    | ARM64 (Apple Silicon) |
| macOS    | Intel (x86_64)        |
| Linux    | x86_64                |
| Linux    | ARM64                 |

### PATH Configuration

If `~/.local/bin` is not in your PATH, add this to your `~/.zshrc` or `~/.bashrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Then reload your shell:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

---

## CLI Commands

The `better-mcp` binary provides several commands for diagnostics and statistics.

### Check Version

```bash
better-mcp --version
```

### View Server Information

```bash
better-mcp --info
```

Displays:

- Server version
- Available tools
- Total component count
- Component breakdown by atomic design level

### View Usage Statistics

```bash
better-mcp --stats
```

Displays:

- Total tool invocations
- Breakdown by atomic design type accessed
- Estimated time saved

The MCP server tracks how you use it and estimates time saved based on typical manual lookup times (2-5 minutes per query).

---

## Client Configuration

After installation, configure your preferred MCP client to use the BetterSuite server.

### Claude Desktop

#### macOS

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "better-mcp": {
      "command": "better-mcp"
    }
  }
}
```

#### Windows

Edit `%APPDATA%\Claude\claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "better-mcp": {
      "command": "better-mcp"
    }
  }
}
```

Restart Claude Desktop after making changes.

---

### Claude Code (CLI)

Add the MCP server using the Claude Code CLI:

```bash
claude mcp add better-mcp better-mcp
```

Or if `~/.local/bin` is not in your PATH, use the full path:

```bash
claude mcp add better-mcp ~/.local/bin/better-mcp
```

---

### VS Code with Cline

1. Open VS Code Settings (JSON)
2. Add the MCP server configuration:

```json
{
  "cline.mcpServers": {
    "better-mcp": {
      "command": "better-mcp"
    }
  }
}
```

---

### VS Code with Continue

Edit your Continue configuration at `~/.continue/config.json`:

```json
{
  "mcpServers": [
    {
      "name": "better-mcp",
      "command": "better-mcp"
    }
  ]
}
```

---

### Cursor IDE

1. Open Cursor Settings
2. Navigate to **Features > MCP Servers**
3. Add a new server with:
   - **Name:** `better-mcp`
   - **Command:** `better-mcp`

---

## Technical Details

| Specification    | Value                                       |
| ---------------- | ------------------------------------------- |
| Protocol         | MCP (Model Context Protocol) 2024-11-05     |
| Transport        | stdio (standard input/output)               |
| Binary           | Self-contained with embedded component data |
| Install Location | `~/.local/bin/better-mcp`                   |
| Config Location  | `~/.config/better-mcp/`                     |

---

## Troubleshooting

### Command not found

If `better-mcp` is not found, ensure `~/.local/bin` is in your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Add this line to your `~/.zshrc` or `~/.bashrc` to make it permanent.

### Client not detecting server

1. Ensure the configuration file path is correct
2. Restart your MCP client after configuration changes
3. Verify the binary exists: `ls -la ~/.local/bin/better-mcp`
4. Check server info: `better-mcp --info`

### Updating the server

Run the installation command again to download the latest version:

**macOS/Linux:**

```bash
curl -sSL https://uploads.bettersuite.io/mcp-update.sh | bash -s -- YOUR_LICENSE_CODE
```

**Windows:**

```powershell
irm https://uploads.bettersuite.io/mcp-update.ps1 | iex; Install-BetterMCP YOUR_LICENSE_CODE
```

### License issues

Your license is stored in `~/.config/better-mcp/.license`. If you need to update it, either:

- Re-run the installer with your license code
- Manually update the file: `echo "YOUR_LICENSE_CODE" > ~/.config/better-mcp/.license`

---

## Next Steps

- [Figma to Flutter](figma-to-flutter) - Convert designs to code
- [Build UI with AI](build-ui-with-ai) - Create screens with natural language
- [Theme Generation](theme-generation) - Generate custom themes
