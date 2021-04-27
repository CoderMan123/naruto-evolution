# Contributing to Naruto Evolution

## Setup Development Environment

Setup instructions can be found [here](README.md#setup-development-environment).

## Conventional Commits

The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention dovetails with [SemVer](http://semver.org/), by describing the features, fixes, and breaking changes made in commit messages.

For more information on the convention, visit the [official website](https://www.conventionalcommits.org/en/v1.0.0/).

### Commit Structure

There are 3 parts to drafting a commit.

1) Subject
2) Body
3) Footer

Each of these parts should be separated by an empty line.

**Example**:
```
<type>(<scope>): <keyword> <description>

<body>

<footer>
```

#### Subject

##### Types

- `release`: a commit of the type release bumps the software version and marks a point of release.
- `feat`: a commit of the type feat is for new features (this correlates with [MINOR](http://semver.org/#summary) in Semantic Versioning).
- `fix`: a commit of the type fix is for patches that address a bug (this correlates with [PATCH](http://semver.org/#summary) in Semantic Versioning).
- `perf`: a commit of the type perf is for changes to performance.
- `docs`: a commit of the type docs is for changes to documentation.
- `ci`: a commit of the type ci is for changes to GitHub Actions.
- `refactor`: a commit of the type refactor is for changes that restructure the source.
- `revert`: a commit of the type revert is for changes that undo a previous commit.

##### Scopes (Optional)

Scopes are optional and are used to provide additional contextual information.

- `ui`: 
- `combat`: 
- `balance`: 
- `build`: 
- `text`: 


##### Keywords
- `add`: 
- `update`: 
- `change`: 
- `fix`:
- `remove`: 

##### Description

##### Breaking Changes

#### Body (Optional)

The body in commit messages are optional and may be used to provide in depth information about the changes being made.

#### Footer (Optional)

The footer in commit messages are optional and may be used to reference issues, pull requests, or provide attribution to a co-author.

### Examples

Here are a list of examples on how to properly draft a commit message.

## Attributions

This document uses excerpts from [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).