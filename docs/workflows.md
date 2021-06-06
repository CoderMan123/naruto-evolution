# GitHub Workflows

| Workflow                  | Description                             | Trigger                   |
| ------------------------- | --------------------------------------- | ------------------------- |
| Build                     | Build (Automatic [Pull Requests])       | Automatic (Pull Requests) |
| Manual Deployment         | Build, Deploy (Manual Trigger)          | Manual                    |
| Release (Alpha Server)    | Build, Deploy (Automatic [develop])     | Automatic: Branch: develop       |
| Release (Beta Server)     | Build, Deploy (Automatic [master])      | Automatic (master)        |
| Release (Official Server) | Build, Release, Deploy (Manual Trigger) | Manual                    |

## Workflow Inputs

### Manual Deployment

- Branch: *\<branch>* - The branch you want to run the workflow on: *master*

- Server *\<server>* - The server you want to deploy to: *official*, *beta*, or *alpha*.

- Version *\<tag>* - The version you want to deploy: *2.0.0*

### Release (Official Server)

- Branch: *\<branch>* - The branch you want to base the release on: *2.0.0*

- Version: *\<version>* - The version number you want to give this release: *2.0.1*

*Do not use the master (or default) branch for releases as the changelog generator will generate a blank changelog.*