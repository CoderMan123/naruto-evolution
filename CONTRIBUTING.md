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

**Commit Structure Example**:
```
<type>(<scope>): <keyword> <description>

<body>

<footer>
```

#### Title

##### Types

- `release`: 
- `feat`: a commit of the type feat introduces a new feature to the codebase (this correlates with [MINOR](http://semver.org/#summary) in Semantic Versioning).
- `fix`: a commit of the type fix patches a bug in your codebase (this correlates with [PATCH](http://semver.org/#summary) in Semantic Versioning).
- `perf`:
- `docs`:
- `ci`: 
- `refactor`:
- `revert`: 

##### Scopes

- `text`:
- `ui`:
- `balance`:

##### Keywords
- `add`: 
- `update`: 
- `change`: 
- `remove`: 

##### Description

##### Breaking Changes

#### Body

#### Footer

### Examples

## Attributions

This document uses excerpts from [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).