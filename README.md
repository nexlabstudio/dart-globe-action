# Dart Globe Action

This GitHub Action allows you to deploy Dart and Flutter applications using the Dart Globe CLI.

## Inputs

| Input          | Description                              | Required | Default |
|----------------|------------------------------------------|----------|---------|
| `github_token` | GitHub Token for authentication          | Yes      |         |
| `globe_token`  | Authentication token for Dart Globe CLI  | Yes      |         |
| `environment`  | Env to deploy (preview or production)    | No       |`preview`|
| `branch`       | Branch to deploy from                    | No       | `main`  |

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
        uses: mastersam07/dart-globe-action@v0.1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          globe_token: ${{ secrets.GLOBE_TOKEN }}
```