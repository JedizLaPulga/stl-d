# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.0.2
### Planned (In Progress)
- **Vector Enhancements**:
  - Element Access: `front()`, `back()`, `at()`, `empty()`, `clear()`.
  - Capacity Management: `reserve()`, `capacity()`, `shrinkToFit()`.
  - Modifiers: `popBack()`, `insert()`, `erase()`.
  - Iteration: Integration with D's `opApply` or range interface (`front`, `popFront`, `empty`) for seamless `foreach` loops.

## 0.0.1
### Added
- Initial setup for `stl-d`, a Standard Template Library for D.
- Established proper `dub.json` structure for a library package.
- Created `source/stl/package.d` to act as the primary import point.
- Created the foundational `Vector` container structure inside `source/stl/container/vector.d`.
