{
  "name": "svc-products",
  "$schema": "../../node_modules/nx/schemas/project-schema.json",
  "sourceRoot": "apps/svc-products/src",
  "projectType": "application",
  "targets": {
    "build": {
      "executor": "@nrwl/webpack:webpack",
      "outputs": [
        "{options.outputPath}"
      ],
      "options": {
        "target": "node",
        "compiler": "tsc",
        "outputPath": "dist/apps/svc-products",
        "main": "apps/svc-products/src/main.ts",
        "tsConfig": "apps/svc-products/tsconfig.app.json",
        "generatePackageJson": true,
        "assets": [
          "apps/svc-products/src/assets"
        ]
      },
      "configurations": {
        "production": {
          "optimization": true,
          "extractLicenses": true,
          "inspect": false,
          "fileReplacements": [
            {
              "replace": "apps/svc-products/src/environments/environment.ts",
              "with": "apps/svc-products/src/environments/environment.prod.ts"
            }
          ]
        }
      }
    },
    "serve": {
      "executor": "@nrwl/js:node",
      "options": {
        "buildTarget": "svc-products:build"
      },
      "configurations": {
        "production": {
          "buildTarget": "svc-products:build:production"
        }
      }
    },
    "lint": {
      "executor": "@nrwl/linter:eslint",
      "outputs": [
        "{options.outputFile}"
      ],
      "options": {
        "lintFilePatterns": [
          "apps/svc-products/**/*.ts"
        ]
      }
    },
    "test": {
      "executor": "@nrwl/jest:jest",
      "outputs": [
        "{workspaceRoot}/coverage/{projectRoot}"
      ],
      "options": {
        "jestConfig": "apps/svc-products/jest.config.ts",
        "passWithNoTests": true
      }
    }
  },
  "tags": []
}
