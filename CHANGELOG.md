# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased
### Added
- New user interface. [[ca0d9086](https://git.douglas-parker.com/Lavenblade/Project-Evolution/-/commit/ca0d908632670f9104fe3bb2c840aebeeaaeb1ca)]

### Changed
- Updated the changelog format.
- Updated the world fps to 20.
- Reworked the social experience. [[e5bcbeb8](https://git.douglas-parker.com/Lavenblade/Project-Evolution/-/commit/e5bcbeb819ace6d3569f5f16f222c43b3035efdf)]
- - Code optimizations to the social experience.
- - Chat messages are no longer discarded when greater than 300 characters in length.
- - Chat messages longer than 600 characters in length will be trimmed and sent back to you instead of losing everything to the abyss.
- - Chat messages containing too many capital letters no longer results in your entire message being made lowercase.
- - Chat messages now have icons to display village and rank.
- - Chat colors have been modified.
- - The Say channel is now known as local.
- - The World channel is now known as Global.
- Tweaked damage overlay animations.
- Damage overlays now have an outline. [[a7ddbf1a](https://git.douglas-parker.com/Lavenblade/Project-Evolution/-/commit/a7ddbf1ab50fc06fd37d2f453f58adf1abfd0b27)]
- Bubble Spreader now spreads in a more combat-viable manner.

### Fixed
- Server optimization.
- - Reduced massive overhead caused by damage overlays. [[d1529b11](https://git.douglas-parker.com/Lavenblade/Project-Evolution/-/commit/d1529b114bc8a46316c6b41db2d31d408776744c)]