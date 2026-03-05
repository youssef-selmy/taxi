# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based admin panel for BetterSuite, a multi-service on-demand platform that manages Taxi (ride-hailing), Shop (e-commerce/delivery), and Parking services. The admin frontend is built using Flutter Web/Desktop and communicates with a GraphQL backend.

## Development Commands

### Code Generation
```bash
# Run build_runner for all code generation (GraphQL, routes, freezed, injectable)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
dart run build_runner clean
```

### Running the Application
```bash
# Run in development mode (uses .env.dev)
flutter run

# Run for web
flutter run -d chrome

# Run for macOS
flutter run -d macos
```

### Icon Generation
When updating icons:
```bash
# Convert SVG strokes to fills (requires oslllo-svg-fixer)
npm i oslllo-svg-fixer -g
oslllo-svg-fixer -s ./ -d ./ --tr 1200

# After importing to icomoon.io and exporting, generate icon font
dart run icomoon_generator:generator
```

### Code Quality
```bash
# Run linter
flutter analyze

# Format code
flutter format lib/

# Sort imports (configured via import_sorter in pubspec.yaml)
dart run import_sorter:main
```

## Architecture

### Overall Structure
The codebase follows **Clean Architecture** principles with feature-based organization:

```
lib/
├── core/                    # Shared infrastructure
│   ├── blocs/              # Global BLoCs (AuthBloc, ConfigBloc, SettingsCubit)
│   ├── router/             # Auto-route configuration and guards
│   ├── locator/            # Dependency injection (GetIt + Injectable)
│   ├── graphql/            # GraphQL client setup, links, scalars
│   ├── repositories/       # Core repositories (profile, config, etc.)
│   └── extensions/         # Dart extensions
├── features/               # Feature modules (see below)
├── config/                 # Environment and theme configuration
└── main.dart              # Application entry point
```

### Feature Organization
Each feature follows a layered structure:

```
features/<feature_name>/
├── data/
│   └── repositories/       # *repository.prod.dart (GraphQL data sources)
├── presentation/
│   ├── blocs/             # BLoCs and Cubits (*bloc.dart, *cubit.dart)
│   ├── screens/           # Screens/Pages (*screen.dart, *page.dart)
│   └── components/        # Reusable UI components
├── <feature_name>_router.dart    # Feature routing configuration
└── <feature_name>_shell_screen.dart  # Feature shell/layout
```

### Main Features
- **taxi/** - Ride-hailing management (drivers, orders, dispatcher)
- **shop/** - E-commerce/delivery management (vendors, products, orders)
- **parking/** - Parking spot management (spots, sessions, orders)
- **customer/** - Customer management and profiles
- **accounting/** - Financial accounting for customers and services
- **marketing/** - Coupons, gift cards, announcements
- **payout/** - Payout methods and sessions for drivers/vendors
- **management_common/** - Staff, regions, payment gateways, SMS providers
- **settings/** - App settings (branding, notifications, sessions)
- **auth/** - Authentication flows

### State Management
- **flutter_bloc** for state management
- **hydrated_bloc** for state persistence (AuthBloc, SettingsCubit)
- **GetIt + Injectable** for dependency injection
  - Use `@lazySingleton` for app-wide singletons
  - Use `@injectable` for feature-scoped services
  - Configure in `lib/core/locator/locator.dart`

### Routing
- **auto_route** for declarative routing
- Route guards for authentication and configuration:
  - `LoginGuard` - Ensures user is authenticated
  - `ConfigGuard` - Ensures app configuration is loaded
  - `DisableConfigGuard` - Prevents access to config screen
- Routes are organized hierarchically with feature routers
- Each screen file must end with `*_screen.dart`, `*_page.dart`, or `*_dialog.dart` to be picked up by code generation

### GraphQL Integration
- Schema defined in `lib/schema.graphql`
- Query/mutation files: `lib/**/*.graphql`
- Custom scalars handled in `lib/core/graphql/scalars/`:
  - `DateTime` - Standard datetime
  - `Timestamp` - Unix timestamp
  - `ConnectionCursor` - Pagination cursors
- WebSocket subscriptions configured via `AppSocketLink`
- Authentication handled via `AuthLink` with automatic token refresh
- Sentry integration for error tracking

### Code Generation Configuration (build.yaml)
- **graphql_codegen**: Generates type-safe GraphQL operations
- **auto_route_generator**: Generates routing code from `@RoutePage` annotations
- **freezed**: Generates immutable models for `.event.dart`, `.state.dart`, `.model.dart`, `.bloc.dart`, `.cubit.dart`
- **injectable_generator**: Generates dependency injection code

### Environment Configuration
- `.env.dev` - Development environment
- `.env.prod` - Production environment
- Configuration class: `lib/config/env.dart`
- Key variables:
  - `API_BASE_URL` - Backend GraphQL endpoint
  - `DEMO_MODE` - Enables demo/testing features
  - `USE_MOCK_API` - Use mock repositories instead of prod
  - `MAPLIBRE_API_KEY` - Map tile provider key

### Design System
- Uses `better_design_system` library (local monorepo package)
- Themes derived from `AppColorScheme` enum (from GraphQL schema)
- Dynamic theming based on selected app type (Taxi/Shop/Parking)
- Dark mode support via `BetterTheme`

## Development Patterns

### Creating a New Feature
1. Create feature folder structure under `lib/features/<feature_name>/`
2. Add repository in `data/repositories/*repository.prod.dart` with `@injectable` annotation
3. Create GraphQL queries/mutations in `.graphql` files
4. Create BLoC/Cubit in `presentation/blocs/` with appropriate file suffix
5. Create screen with `*_screen.dart`, `*_page.dart`, or `*_dialog.dart` suffix
6. Add feature router in `<feature_name>_router.dart`
7. Register routes in `lib/core/router/app_router.dart`
8. Run code generation: `dart run build_runner build --delete-conflicting-outputs`

### BLoC/Cubit Naming
- Use `*bloc.dart` for complex state machines with events
- Use `*cubit.dart` for simpler state management
- State classes: `*state.dart` with Freezed
- Event classes: `*event.dart` with Freezed

### Repository Pattern
- Production repositories: `*repository.prod.dart` (uses GraphQL datasources)
- Mock repositories: `*repository.mock.dart` (for testing/demo)
- Injectable environment controls which is used (dev vs prod)

### Authentication Flow
1. User logs in via `LoginRoute` → `AuthBloc` receives `Login` event
2. `ProfileRepository.login()` fetches JWT tokens
3. Tokens stored in `AuthBloc` state (persisted via HydratedBloc)
4. `GraphQLClient` uses `AuthLink` to attach Bearer token to requests
5. Token refresh handled automatically when expiry is within 5 minutes
6. `LoginGuard` protects authenticated routes

### Multi-App Type Support
The platform supports three app types: Taxi, Shop, Parking. The selected type affects:
- Theme colors (via `AppColorScheme`)
- Available routes and features
- Dashboard content
- Stored in `AuthBloc.state.selectedAppType`

## Important Constraints

### File Naming Conventions
- Screens/Pages: Must end with `_screen.dart`, `_page.dart`, or `_dialog.dart`
- BLoCs: Must end with `.bloc.dart` or `.cubit.dart`
- States/Events/Models: Must end with `.state.dart`, `.event.dart`, `.model.dart`
- Repositories: Must end with `_repository.prod.dart` or `_repository.mock.dart`
- GraphQL files: Must end with `.graphql`

### Code Generation Dependencies
After modifying:
- GraphQL schema/queries → Run build_runner
- Route annotations → Run build_runner
- Freezed classes (states/events/models) → Run build_runner
- Injectable annotations → Run build_runner

### Monorepo Dependencies
Local packages referenced in `pubspec.yaml`:
- `better_design_system` - UI component library
- `better_assets` - Shared assets
- `better_icons` - Icon fonts
- `better_localization` - Localization utilities

These are located in `../../libs/` relative to the project root.
