# GitHub Workflows

| Workflow                  | Jobs                   | Trigger                    |
| ------------------------- | ---------------------- | -------------------------- |
| Build                     | Build                  | Automatic: *Pull Requests* |
| Manual Deployment         | Build, Deploy          | Manual                     |
| Release (Alpha Server)    | Build, Deploy          | Automatic: *develop*       |
| Release (Beta Server)     | Build, Deploy          | Automatic: *master*        |
| Release (Official Server) | Build, Release, Deploy | Manual                     |

## Workflow Inputs

### Manual Deployment

- **Branch** - The branch you want to run the workflow on: *master*

- **Server** - The server you want to deploy to: *official*, *beta*, or *alpha*.

- **Version** - The version you want to deploy: *2.0.0*

### Release (Official Server)

- **Branch** - The branch you want to base the release on: *2.0.0*

- **Version** - The version number you want to give this release: *2.0.1*

***Warning:** Do <u>not</u> use the master (or default) branch for releases as the changelog generator will generate a blank changelog.*