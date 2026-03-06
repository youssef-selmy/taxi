#!/bin/bash

# BetterUI - Local Docker Publishing Script
# This script allows local publishing of widgetbook and showcase apps to GHCR
# Usage: ./docker-publish.sh

set -e  # Exit on error

# Source configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Need to set DESIGN_SYSTEM_ROOT before sourcing config.sh
export DESIGN_SYSTEM_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

source "${SCRIPT_DIR}/config.sh"

# Load .env file
log_step "Loading environment configuration"
if load_env_file; then
    log_success "Environment variables loaded from .env"
else
    log_warning ".env file not found, using existing environment variables"
fi

# Banner
echo -e "${COLOR_CYAN}${COLOR_BOLD}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║   BetterUI - Docker Publishing Tool           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${COLOR_RESET}\n"

# Check prerequisites
if ! check_prerequisites; then
    exit 1
fi

# Interactive prompts

# 1. Select app(s) to publish
echo -e "${COLOR_BOLD}Select which app(s) to publish:${COLOR_RESET}"
echo "  1) Widgetbook"
echo "  2) Showcase"
echo "  3) Both"
echo ""
read -p "Enter your choice (1-3): " app_choice

case $app_choice in
    1)
        APPS_TO_PUBLISH=("widgetbook")
        ;;
    2)
        APPS_TO_PUBLISH=("showcase")
        ;;
    3)
        APPS_TO_PUBLISH=("widgetbook" "showcase")
        ;;
    *)
        log_error "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""

# 2. Extract versions from pubspec.yaml files
log_step "Extracting versions from pubspec.yaml"

# Extract and store versions
WIDGETBOOK_VERSION=""
SHOWCASE_VERSION=""

for app in "${APPS_TO_PUBLISH[@]}"; do
    APP_PATH="${DESIGN_SYSTEM_ROOT}/${app}"
    PUBSPEC_PATH="${APP_PATH}/pubspec.yaml"

    version=$(extract_version_from_pubspec "$PUBSPEC_PATH" "$app")
    if [ $? -ne 0 ]; then
        log_error "Failed to extract version for ${app}"
        exit 1
    fi

    # Store version for the app
    if [ "$app" = "widgetbook" ]; then
        WIDGETBOOK_VERSION="$version"
    elif [ "$app" = "showcase" ]; then
        SHOWCASE_VERSION="$version"
    fi
done

echo ""

# 3. Confirm before proceeding
echo -e "${COLOR_YELLOW}${COLOR_BOLD}Summary:${COLOR_RESET}"
for app in "${APPS_TO_PUBLISH[@]}"; do
    if [ "$app" = "widgetbook" ]; then
        echo "  ${app}: v${WIDGETBOOK_VERSION}"
    elif [ "$app" = "showcase" ]; then
        echo "  ${app}: v${SHOWCASE_VERSION}"
    fi
done
echo "  Registry: ${GHCR_REGISTRY}/${GHCR_ORG}"
echo ""
read -p "Continue? (y/N): " confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    log_warning "Cancelled by user"
    exit 0
fi

echo ""

# Docker login
if ! docker_login_ghcr; then
    exit 1
fi

# Setup localizations dependency
if ! setup_localizations; then
    log_error "Failed to setup flutter_localizations dependency"
    exit 1
fi

# Install dependencies for main lib
log_step "Installing dependencies for main library"
if ! flutter_pub_get "$DESIGN_SYSTEM_ROOT" "better_design_system"; then
    exit 1
fi

# Process each app
for app in "${APPS_TO_PUBLISH[@]}"; do
    # Get version for this app
    if [ "$app" = "widgetbook" ]; then
        version="$WIDGETBOOK_VERSION"
        IMAGE_NAME="$WIDGETBOOK_IMAGE"
    elif [ "$app" = "showcase" ]; then
        version="$SHOWCASE_VERSION"
        IMAGE_NAME="$SHOWCASE_IMAGE"
    fi

    log_step "Processing ${app} (v${version})"

    APP_PATH="${DESIGN_SYSTEM_ROOT}/${app}"

    # 1. Install dependencies
    if ! flutter_pub_get "$APP_PATH" "$app"; then
        log_error "Failed to install dependencies for ${app}"
        exit 1
    fi

    # 2. Generate localizations
    if ! flutter_gen_l10n "$APP_PATH" "$app"; then
        log_warning "Localizations generation had issues for ${app}, continuing..."
    fi

    # 3. Run build_runner
    if ! flutter_build_runner "$APP_PATH" "$app"; then
        log_error "Failed to run build_runner for ${app}"
        exit 1
    fi

    # 4. Build Flutter web
    if ! flutter_build_web "$APP_PATH" "$app"; then
        log_error "Failed to build Flutter web for ${app}"
        exit 1
    fi

    # 5. Build and push Docker image
    if ! docker_build_push "$APP_PATH" "$app" "$IMAGE_NAME" "$version"; then
        log_error "Failed to build/push Docker image for ${app}"
        exit 1
    fi

    log_success "✓ ${app} (v${version}) published successfully!"
    echo ""
done

# Success summary
echo ""
log_step "🎉 Publishing complete!"
echo ""
echo -e "${COLOR_GREEN}${COLOR_BOLD}Published images:${COLOR_RESET}"
for app in "${APPS_TO_PUBLISH[@]}"; do
    # Get version for this app
    if [ "$app" = "widgetbook" ]; then
        version="$WIDGETBOOK_VERSION"
        echo "  • ${WIDGETBOOK_IMAGE}:${version}"
    elif [ "$app" = "showcase" ]; then
        version="$SHOWCASE_VERSION"
        echo "  • ${SHOWCASE_IMAGE}:${version}"
    fi
    echo -e "    ${COLOR_CYAN}Tags: ${version}, $(echo $version | cut -d. -f1-2), $(echo $version | cut -d. -f1), latest${COLOR_RESET}"
done
echo ""
