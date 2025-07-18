# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 1.0.2
- trivial internal renaming

## 1.0.1
- some internal refactoring, nothing major

## 1.0.0

### Added
- enabled various rubocop NewCops
- additional documentation in the README

### Changed
- minor code adjustments to adhere to newly enabled lint rules
- use custom error message for missing data

## 0.5.0

### Added
- integration tests using example files

### Changed
- Rubocop allows multiple expectations per example
- calculate_averages binary now rounds result to two decimal places
- updated documentation in README

## 0.4.0

### Added
- First unit tests, including factories and rspec configurations

### Removed
- rake was barely used
- unneeded calculator class

## 0.3.0

### Added
- calculate_averages binary now takes files as arguments for DB initialisation
- calculate_averages now prints results

## 0.2.2

### Changed
- Install specific package version in CI smoke test workflow
- Install development dependencies from gemspec instead of Gemfile

## 0.2.1

### Changed
- Updated the smoke test workflow syntax to run in CI

## 0.2.0

### Added
- ActiveRecord models to represent `property` and `street` data
- Binary executable to run the application from the command line

### Changed

### Removed
- `steep` typechecking, it was just getting in the way for now. Might revisit later.

## 0.1.0

This was an empty gem released to verify the build automation. Do not use this gem or expect it to do anything useful.
