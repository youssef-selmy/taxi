#!/bin/bash

# Configuration for BetterUI Docker Publishing

# Load .env file if it exists
load_env_file() {
    local env_file="${DESIGN_SYSTEM_ROOT}/.env"

    if [ -f "$env_file" ]; then
        # Load .env file, ignoring comments and empty lines
        while IFS= read -r line; do
            # Skip comments and empty lines
            [[ "$line" =~ ^#.*$ ]] && continue
            [[ -z "$line" ]] && continue

            # Extract key and value
            if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
                key="${BASH_REMATCH[1]}"
                value="${BASH_REMATCH[2]}"

                # Remove leading/trailing whitespace from key
                key=$(echo "$key" | xargs)

                # Remove quotes from value if present
                value="${value%\"}"
                value="${value#\"}"
                value="${value%\'}"
                value="${value#\'}"

                # Export variable
                export "$key=$value"
            fi
        done < "$env_file"

        return 0
    else
        return 1
    fi
}

# Registry Configuration
export GHCR_REGISTRY="ghcr.io"
export GHCR_ORG="lumeagency"
export BASE_IMAGE="ghcr.io/lumeagency/flutter-web-server:1.1.2"

# Image Names
export WIDGETBOOK_IMAGE="${GHCR_REGISTRY}/${GHCR_ORG}/better-design-system-widgetbook"
export SHOWCASE_IMAGE="${GHCR_REGISTRY}/${GHCR_ORG}/better-design-system-showcase"

# Flutter Configuration
export FLUTTER_VERSION="3.35.5"
export FLUTTER_CHANNEL="stable"

# Repository Paths
export DESIGN_SYSTEM_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export LOCALIZATIONS_PATH="${DESIGN_SYSTEM_ROOT}/../flutter_localizations"
export LOCALIZATIONS_REPO="https://github.com/LumeAgency/flutter-localizations.git"

# Colors for output
export COLOR_RESET='\033[0m'
export COLOR_RED='\033[0;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_CYAN='\033[0;36m'
export COLOR_BOLD='\033[1m'

# Helper Functions

log_info() {
    echo -e "${COLOR_BLUE}ℹ${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_GREEN}✓${COLOR_RESET} $1"
}

log_warning() {
    echo -e "${COLOR_YELLOW}⚠${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_RED}✗${COLOR_RESET} $1"
}

log_step() {
    echo -e "\n${COLOR_CYAN}${COLOR_BOLD}▶${COLOR_RESET} ${COLOR_BOLD}$1${COLOR_RESET}\n"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check required tools
check_prerequisites() {
    log_step "Checking prerequisites"

    local missing_tools=()

    if ! command_exists flutter; then
        missing_tools+=("flutter")
    fi

    if ! command_exists docker; then
        missing_tools+=("docker")
    fi

    if ! command_exists git; then
        missing_tools+=("git")
    fi

    if [ ${#missing_tools[@]} -ne 0 ]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        return 1
    fi

    log_success "All required tools are installed"

    # Check Flutter version
    local current_flutter_version=$(flutter --version | grep "Flutter" | awk '{print $2}')
    log_info "Flutter version: ${current_flutter_version}"

    # Check Docker daemon
    if ! docker info >/dev/null 2>&1; then
        log_error "Docker daemon is not running"
        return 1
    fi
    log_success "Docker daemon is running"

    return 0
}

# Extract version from pubspec.yaml
extract_version_from_pubspec() {
    local pubspec_path=$1
    local app_name=$2

    if [ ! -f "$pubspec_path" ]; then
        log_error "pubspec.yaml not found at: $pubspec_path" >&2
        return 1
    fi

    # Extract version line and parse it
    local version=$(grep "^version:" "$pubspec_path" | sed 's/version: *//g' | sed 's/+.*$//g' | tr -d ' ')

    if [ -z "$version" ]; then
        log_error "Could not extract version from $pubspec_path" >&2
        return 1
    fi

    # Validate semantic version format
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        log_error "Invalid version format in pubspec.yaml: $version (expected: X.Y.Z)" >&2
        return 1
    fi

    log_info "Extracted version for ${app_name}: ${version}" >&2
    echo "$version"
}

# Parse semantic version into tags
generate_version_tags() {
    local version=$1
    local tags=()

    # Validate semantic version format
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        log_error "Invalid version format: $version (expected: X.Y.Z)" >&2
        return 1
    fi

    # Split version into components
    IFS='.' read -r major minor patch <<< "$version"

    # Generate tags: 1.2.3, 1.2, 1, latest
    tags+=("$major.$minor.$patch")
    tags+=("$major.$minor")
    tags+=("$major")
    tags+=("latest")

    echo "${tags[@]}"
}

# Docker login to GHCR
docker_login_ghcr() {
    log_step "Authenticating with GitHub Container Registry"

    if [ -z "$GITHUB_TOKEN" ]; then
        log_error "GITHUB_TOKEN environment variable is not set"
        log_info "Please set your GitHub Personal Access Token:"
        log_info "  export GITHUB_TOKEN=your_token_here"
        return 1
    fi

    if [ -z "$GHCR_USERNAME" ]; then
        log_warning "GHCR_USERNAME not set, using default: LumeAgency"
        export GHCR_USERNAME="LumeAgency"
    fi

    echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GHCR_USERNAME" --password-stdin >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        log_success "Successfully authenticated with GHCR"
        return 0
    else
        log_error "Failed to authenticate with GHCR"
        return 1
    fi
}

# Clone or update flutter_localizations dependency
setup_localizations() {
    log_step "Setting up flutter_localizations dependency"

    if [ -d "$LOCALIZATIONS_PATH" ]; then
        log_info "flutter_localizations already exists, pulling latest changes"
        cd "$LOCALIZATIONS_PATH" || return 1
        git pull origin main >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            log_success "Updated flutter_localizations"
        else
            log_warning "Could not update flutter_localizations, using existing version"
        fi
        cd "$DESIGN_SYSTEM_ROOT" || return 1
    else
        log_info "Cloning flutter_localizations repository"

        if [ -z "$GITHUB_TOKEN" ]; then
            log_error "GITHUB_TOKEN required to clone private repository"
            return 1
        fi

        # Clone using token authentication
        git clone "https://${GITHUB_TOKEN}@github.com/LumeAgency/flutter-localizations.git" "$LOCALIZATIONS_PATH" >/dev/null 2>&1

        if [ $? -eq 0 ]; then
            log_success "Cloned flutter_localizations"
        else
            log_error "Failed to clone flutter_localizations"
            return 1
        fi
    fi

    return 0
}

# Run Flutter pub get
flutter_pub_get() {
    local app_path=$1
    local app_name=$2

    log_info "Running flutter pub get for ${app_name}"
    cd "$app_path" || return 1
    flutter pub get >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        log_success "Dependencies installed for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 0
    else
        log_error "Failed to install dependencies for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 1
    fi
}

# Run Flutter gen-l10n
flutter_gen_l10n() {
    local app_path=$1
    local app_name=$2

    log_info "Generating localizations for ${app_name}"
    cd "$app_path" || return 1
    flutter gen-l10n >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        log_success "Localizations generated for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 0
    else
        log_warning "Localizations generation skipped or failed for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 0  # Non-critical, continue
    fi
}

# Run build_runner
flutter_build_runner() {
    local app_path=$1
    local app_name=$2

    log_info "Running build_runner for ${app_name}"
    cd "$app_path" || return 1
    dart run build_runner build -d --delete-conflicting-outputs >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        log_success "Code generation completed for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 0
    else
        log_error "Code generation failed for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 1
    fi
}

# Build Flutter web app
flutter_build_web() {
    local app_path=$1
    local app_name=$2

    log_info "Building Flutter web app for ${app_name} (with WASM)"
    cd "$app_path" || return 1
    flutter build web --release --wasm >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        log_success "Flutter web build completed for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 0
    else
        log_error "Flutter web build failed for ${app_name}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 1
    fi
}

# Build and push Docker image
docker_build_push() {
    local app_path=$1
    local app_name=$2
    local image_name=$3
    local version=$4

    log_step "Building and pushing Docker image for ${app_name}"

    # Generate version tags
    local tags=($(generate_version_tags "$version"))
    if [ $? -ne 0 ]; then
        return 1
    fi

    # Build tag arguments
    local tag_args=""
    for tag in "${tags[@]}"; do
        tag_args="$tag_args -t ${image_name}:${tag}"
        log_info "Will tag as: ${image_name}:${tag}"
    done

    cd "$app_path" || return 1

    # Build and push
    log_info "Building Docker image"
    docker buildx build --platform linux/amd64 ${tag_args} --push . >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        log_success "Docker image built and pushed successfully"
        log_success "Published: ${image_name}:${version}"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 0
    else
        log_error "Docker build/push failed"
        cd "$DESIGN_SYSTEM_ROOT" || return 1
        return 1
    fi
}
