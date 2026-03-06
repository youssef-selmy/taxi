# BetterUI - Docker Publishing Tools

This directory contains tools for publishing the BetterUI applications (Widgetbook and Showcase) to GitHub Container Registry (GHCR).

## Overview

The publishing script mirrors the GitHub Actions workflow but allows for local execution with full control over versioning and app selection.

## Files

- **docker-publish.sh** - Main publishing script with interactive prompts
- **config.sh** - Shared configuration and helper functions
- **.env.example** - Environment variable template

## Prerequisites

### Required Tools

- **Flutter** (3.35.5 or compatible)
- **Docker** with buildx support
- **Git**

### Required Credentials

1. **GitHub Personal Access Token** with permissions:
   - `repo` (Full control of private repositories)
   - `write:packages` (Upload packages to GHCR)
   - `read:packages` (Download packages from GHCR)

Create a token at: https://github.com/settings/tokens

## Setup

### 1. Configure Environment Variables

```bash
# Copy the example file
cp ../.env.example ../.env

# Edit .env and add your GITHUB_TOKEN
nano ../.env
```

Or export variables manually:

```bash
export GITHUB_TOKEN=your_github_personal_access_token
export GHCR_USERNAME=LumeAgency  # Optional, defaults to LumeAgency
```

### 2. Ensure Docker is Running

```bash
# Check Docker daemon
docker info
```

## Usage

### Basic Usage

```bash
cd libs/better_design_system
./tools/docker-publish.sh
```

The script will automatically:

1. **Load `.env` file** - Reads GITHUB_TOKEN and other variables
2. **Prompt for app selection** - Widgetbook, Showcase, or Both
3. **Extract versions** - Reads from each app's `pubspec.yaml`
4. **Show confirmation** - Review summary before publishing

### Example Session

```
▶ Loading environment configuration
✓ Environment variables loaded from .env

╔════════════════════════════════════════════════════════════╗
║   BetterUI - Docker Publishing Tool           ║
╚════════════════════════════════════════════════════════════╝

▶ Checking prerequisites
✓ All required tools are installed
ℹ Flutter version: 3.35.5
✓ Docker daemon is running

Select which app(s) to publish:
  1) Widgetbook
  2) Showcase
  3) Both

Enter your choice (1-3): 1

▶ Extracting versions from pubspec.yaml
ℹ Extracted version for widgetbook: 1.2.3

Summary:
  widgetbook: v1.2.3
  Registry: ghcr.io/lumeagency

Continue? (y/N): y

▶ Authenticating with GitHub Container Registry
✓ Successfully authenticated with GHCR

▶ Setting up flutter_localizations dependency
✓ Cloned flutter_localizations

▶ Installing dependencies for main library
✓ Dependencies installed for better_design_system

▶ Processing widgetbook (v1.2.3)
ℹ Running flutter pub get for widgetbook
✓ Dependencies installed for widgetbook
ℹ Generating localizations for widgetbook
✓ Localizations generated for widgetbook
ℹ Running build_runner for widgetbook
✓ Code generation completed for widgetbook
ℹ Building Flutter web app for widgetbook (with WASM)
✓ Flutter web build completed for widgetbook

▶ Building and pushing Docker image for widgetbook
ℹ Will tag as: ghcr.io/lumeagency/better-design-system-widgetbook:1.2.3
ℹ Will tag as: ghcr.io/lumeagency/better-design-system-widgetbook:1.2
ℹ Will tag as: ghcr.io/lumeagency/better-design-system-widgetbook:1
ℹ Will tag as: ghcr.io/lumeagency/better-design-system-widgetbook:latest
ℹ Building Docker image
✓ Docker image built and pushed successfully
✓ Published: ghcr.io/lumeagency/better-design-system-widgetbook:1.2.3
✓ widgetbook (v1.2.3) published successfully!

▶ 🎉 Publishing complete!

Published images:
  • ghcr.io/lumeagency/better-design-system-widgetbook:1.2.3
    Tags: 1.2.3, 1.2, 1, latest
```

## Versioning

The script implements **automatic semantic versioning**:

### Version Source

Versions are automatically extracted from each app's `pubspec.yaml`:

```yaml
# widgetbook/pubspec.yaml
version: 1.2.3+1 # Extracts: 1.2.3 (build number ignored)
```

To publish a new version, simply update the version in `pubspec.yaml` and run the script.

### Generated Tags

For version `1.2.3`, the following tags are created:

- `1.2.3` (patch version - exact)
- `1.2` (minor version - latest patch)
- `1` (major version - latest minor)
- `latest` (latest release)

This allows users to:

- Pin to exact version: `docker pull ghcr.io/lumeagency/better-design-system-widgetbook:1.2.3`
- Use minor updates: `docker pull ghcr.io/lumeagency/better-design-system-widgetbook:1.2`
- Use major updates: `docker pull ghcr.io/lumeagency/better-design-system-widgetbook:1`
- Always get latest: `docker pull ghcr.io/lumeagency/better-design-system-widgetbook:latest`

## Build Process

The script executes the following steps:

### Initialization

1. **Load `.env` file** - Reads environment variables
2. **Check prerequisites** - Validates Flutter, Docker, Git
3. **Extract versions** - Reads from `pubspec.yaml` files
4. **Authenticate with GHCR** - Docker login using GITHUB_TOKEN
5. **Setup dependencies** - Clone/update flutter_localizations

### For Each Selected App

6. **Install dependencies** - `flutter pub get`
7. **Generate localizations** - `flutter gen-l10n`
8. **Run code generation** - `dart run build_runner build -d --delete-conflicting-outputs`
9. **Build web app** - `flutter build web --release --wasm`
10. **Build Docker image** - Multi-tagged image with buildx
11. **Push to GHCR** - Push all version tags

## Published Images

### Widgetbook

- **Image:** `ghcr.io/lumeagency/better-design-system-widgetbook`
- **Purpose:** Component development environment
- **Base:** `ghcr.io/lumeagency/flutter-web-server:1.1.2`

### Showcase

- **Image:** `ghcr.io/lumeagency/better-design-system-showcase`
- **Purpose:** Full demo app with complete screens
- **Base:** `ghcr.io/lumeagency/flutter-web-server:1.1.2`

## Dependencies

The script automatically manages the `flutter_localizations` dependency:

- Checks if `../flutter_localizations` exists
- Clones from private repo if missing (requires GITHUB_TOKEN)
- Pulls latest changes if already present

## Troubleshooting

### "GITHUB_TOKEN environment variable is not set"

**Solution:** Export your GitHub token:

```bash
export GITHUB_TOKEN=your_token_here
```

### "Failed to authenticate with GHCR"

**Causes:**

- Invalid or expired token
- Token lacks required permissions (`write:packages`, `read:packages`)

**Solution:** Create a new token with correct scopes

### "Failed to clone flutter_localizations"

**Causes:**

- Token lacks `repo` scope for private repositories
- Network connectivity issues

**Solution:** Ensure token has `repo` scope and check network

### "Docker daemon is not running"

**Solution:** Start Docker Desktop or Docker daemon:

```bash
# macOS
open -a Docker

# Linux
sudo systemctl start docker
```

### "Flutter build failed"

**Causes:**

- Dependency issues
- Code generation errors
- Platform incompatibilities

**Solution:** Run build steps manually to identify the issue:

```bash
cd widgetbook  # or showcase
flutter pub get
dart run build_runner build -d --delete-conflicting-outputs
flutter build web --release --wasm
```

## Script Configuration

Configuration is centralized in `config.sh`:

```bash
# Registry
GHCR_REGISTRY="ghcr.io"
GHCR_ORG="lumeagency"

# Images
WIDGETBOOK_IMAGE="ghcr.io/lumeagency/better-design-system-widgetbook"
SHOWCASE_IMAGE="ghcr.io/lumeagency/better-design-system-showcase"

# Flutter
FLUTTER_VERSION="3.35.5"
FLUTTER_CHANNEL="stable"
```

Modify these values to customize for your organization or registry.

## Comparison: CI/CD vs Local

| Feature        | GitHub Actions     | Local Script                                  |
| -------------- | ------------------ | --------------------------------------------- |
| Trigger        | Push to main       | Manual execution                              |
| Versioning     | `latest` tag only  | Semantic versioning (X.Y.Z, X.Y, X, latest)   |
| App Selection  | Both apps          | Interactive choice (widgetbook/showcase/both) |
| Authentication | GitHub secrets     | Local environment variables                   |
| Flexibility    | Fixed workflow     | Full control over process                     |
| Use Case       | Automated releases | Testing, hotfixes, custom releases            |

## Security Notes

- Never commit `.env` file with credentials
- `.env` is gitignored by default
- GitHub tokens should be treated as passwords
- Use fine-grained tokens when possible
- Rotate tokens regularly

## Contributing

When modifying the scripts:

1. **Maintain backward compatibility** with existing workflows
2. **Test thoroughly** before committing
3. **Update documentation** for any new features
4. **Follow bash best practices**:
   - Use `set -e` for error handling
   - Quote variables to prevent word splitting
   - Validate inputs before processing
   - Provide clear error messages

## Support

For issues or questions:

- Check troubleshooting section above
- Review GitHub Actions workflow: `.github/workflows/deploy-widgetbook-to-docker.yaml`
- Consult BetterUI documentation: `../CLAUDE.md`

## License

Part of the BetterUI monorepo. See root LICENSE file.
