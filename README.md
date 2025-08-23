# Dart Globe Action

This GitHub Action allows you to deploy Dart and Flutter applications using the Dart Globe CLI.

## Prerequisites

Before using this action, you need to create a `globe.yaml` configuration file in your project root. This file defines your application's deployment settings.

### globe.yaml Configuration

Create a `globe.yaml` file in your project root with the following structure:

```yaml
# Required: The main entry point of your Dart application
entrypoint: "lib/main.dart"

# Optional: Static assets to include in deployment
# These are files that don't change at runtime (PNG, CSS, HTML, fonts, compiled WASM)
# Globe serves these assets via a global edge network for speedy delivery worldwide
assets:
  - "public/index.html"
  - "public/styles.css"
  - "public/images/logo.png"

# Optional: Preferred deployment regions for better performance
# Globe optimizes performance by serving from the closest edge locations to your users
preferred_regions:
  - "europe-west1"
  - "us-central1"

# Optional: Scheduled cron jobs for background processing
# Used for data synchronization, periodic tasks, or any scheduled operations
crons:
  - id: "daily_report"
    path: "/api/cron/daily-report"
    schedule: "0 0 * * *" # Every day at midnight UTC
  - id: "hourly_sync"
    path: "/api/cron/sync-data"
    schedule: "0 * * * *" # Every hour

# Optional: Build configuration for your Dart application
build:
  # Framework preset configuration
  preset:
    type: "dart_frog"  # Available: dart_frog, jaspr, flutter, serverpod
    version: "1.0.0"
    buildCommand: "dart_frog build"
  
  # Melos configuration for monorepo builds
  melos:
    automatic_detection: true  # Default: true
    command: "melos run build"
    version: "3.0.0"
  
  # Build runner configuration for code generation
  build_runner:
    automatic_detection: true  # Default: true
    command: "dart run build_runner build"
```

### Configuration Options

#### Entrypoint
- **Required**: The main entry point of your Dart application
- Example: `entrypoint: "lib/main.dart"`

#### Assets
- **Optional**: Static assets are files that don't change at runtime
- Includes: PNG, CSS, HTML, fonts, compiled WASM files
- Globe serves these assets via a global edge network for speedy delivery worldwide
- Example: `assets: ["public/", "build/web/"]`

#### Preferred Regions
- **Optional**: A list of preferred regions for your deployment
- Helps Globe optimize performance by serving from the closest edge locations to your users
- Available regions:
  - **Africa**: `africa-south1`
  - **Asia**: `asia-east1`, `asia-east2`, `asia-northeast1`, `asia-northeast2`, `asia-northeast3`, `asia-southeast1`, `asia-southeast2`, `asia-south1`, `asia-south2`
  - **Australia**: `australia-southeast1`, `australia-southeast2`
  - **Europe**: `europe-north1`, `europe-southwest1`, `europe-west1`, `europe-west2`, `europe-west3`, `europe-west4`, `europe-west6`, `europe-west8`, `europe-west9`, `europe-west10`, `europe-west12`, `europe-central2`
  - **Middle East**: `me-west1`, `me-central1`
  - **North America**: `us-central1`, `us-east1`, `us-east4`, `us-east5`, `us-south1`, `us-west1`, `us-west2`, `us-west3`, `us-west4`, `northamerica-northeast1`, `northamerica-northeast2`
  - **South America**: `southamerica-east1`, `southamerica-west1`

#### Cron Jobs
- **Optional**: Scheduled tasks that run at specified intervals
- Used for background processing, data synchronization, or periodic tasks
- Each cron job requires:
  - `id`: Unique identifier (1-50 characters, lowercase letters, digits, underscores only)
  - `path`: API endpoint path (minimum 1 character)
  - `schedule`: Cron expression (minimum 1 character)
- Uses standard cron syntax

#### Build Configuration
- **Optional**: Build settings for your Dart application
- **Preset**: Framework-specific build configuration
  - Available types: `dart_frog`, `jaspr`, `flutter`, `serverpod`
  - `version`: Framework version
  - `buildCommand`: Custom build command
- **Melos**: Monorepo build configuration
  - `automatic_detection`: Auto-detect Melos (default: true)
  - `command`: Melos build command
  - `version`: Melos version
- **Build Runner**: Code generation configuration
  - `automatic_detection`: Auto-detect build_runner (default: true)
  - `command`: Build runner command

## Inputs

| Input              | Description                              | Required | Default |
|--------------------|------------------------------------------|----------|---------|
| `globe_token`      | Authentication token for Dart Globe CLI  | Yes      |         |
| `environment`      | Env to deploy (preview or production)    | No       |`preview`|
| `working-directory`| Directory containing globe.yaml          | No       | `.`     |
| `project-id`       | Project ID/Slug used by Globe            | Yes      |         |
| `org-id`           | Organization ID/Slug used by Globe       | Yes      |         |

## Example Usage

```yaml
name: Deploy Application
on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy using Dart Globe
        uses: mastersam07/dart-globe-action@master
        with:
          globe-token: ${{ secrets.GLOBE_ACTION_TOKEN }}
          project-id: ${{ secrets.GLOBE_PROJECT_ID }}
          org-id: ${{ secrets.GLOBE_ORG_ID }}
```

## Example globe.yaml for Different Project Types

### Basic Dart Application
```yaml
entrypoint: "lib/main.dart"
```

### Dart Frog Application
```yaml
entrypoint: "lib/main.dart"
build:
  preset:
    type: "dart_frog"
    version: "1.0.0"
    buildCommand: "dart_frog build"
```

### Jaspr Application
```yaml
entrypoint: "lib/main.dart"
build:
  preset:
    type: "jaspr"
    version: "1.0.0"
```

### Flutter Web Application
```yaml
entrypoint: "lib/main.dart"
assets:
  - "build/web/"
preferred_regions:
  - "us-central1"
  - "europe-west1"
```

### Serverpod Application
```yaml
entrypoint: "lib/main.dart"
build:
  preset:
    type: "serverpod"
    version: "1.0.0"
```

### Application with Cron Jobs
```yaml
entrypoint: "lib/main.dart"
crons:
  - id: "daily_cleanup"
    path: "/api/cron/cleanup"
    schedule: "0 2 * * *" # Daily at 2 AM UTC
  - id: "weekly_backup"
    path: "/api/cron/backup"
    schedule: "0 3 * * 0" # Weekly on Sunday at 3 AM UTC
```

### Monorepo with Melos
```yaml
entrypoint: "lib/main.dart"
build:
  melos:
    automatic_detection: true
    command: "melos run build"
    version: "3.0.0"
  build_runner:
    automatic_detection: true
    command: "dart run build_runner build"
```