# Dart Globe Action

This GitHub Action allows you to deploy Dart and Flutter applications using the Dart Globe CLI.

## Inputs

| Input              | Description                              | Required | Default |
|--------------------|------------------------------------------|----------|---------|
| `globe_token`      | Authentication token for Dart Globe CLI  | Yes      |         |
| `environment`      | Env to deploy (preview or production)    | No       |`preview`|
| `working-directory`| Branch to deploy from                    | No       | `.`     |
| `entrypoint`       | Entry point to dart app                  | Yes      |         |

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
        uses: mastersam07/dart-globe-action@v0.21
        with:
          entrypoint: build/bin/server.dart
          globe_token: ${{ secrets.GLOBE_TOKEN }}
```