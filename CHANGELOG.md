# Changelog

All notable changes to this project are documented in this file.

## [1.1.5] - 2026-01-29

### Fixed
- **Task Scheduling**: `schtasks /create` no longer blindly reports success — the script now checks the real exit code before printing "Task scheduled successfully."
- **Time input validation**: Replaced the invalid `findstr` alternation pattern (`findstr` doesn't reliably support `()`/`|` groups) with a two-step check — format validation followed by numeric range validation (00–23 for hours, 00–59 for minutes). Previously, invalid times like `29:99`, `25:00`, or `24:30` could slip through.
- **Full Clean**: Every step (Temp, Prefetch, DNS flush, Recycle Bin, Thumbnail Cache, WER files) now checks and reports its own exit code instead of always claiming success.
- **Browser Cache Cleaner**:
  - Detects whether Chrome, Edge, or Firefox are actually installed before attempting cleanup, and skips with a clear `[SKIP]` message if not.
  - Now reports the *real* result of each `del` command per browser instead of hardcoding a pass.
- **Font Cache Cleaner**: Now checks the result of `net stop FontCache` in addition to `net start FontCache`.
- **Windows Error Reporting Cleanup**: Added proper error checking (previously had none).
- **Temp Cleaner**: Now reports `Found / Deleted / Remaining` file counts instead of just a file count and a generic "Done."
- **Disk Health Check**: Removed dependency on `wmic` (deprecated/removed in recent Windows builds) in favor of PowerShell-only checks (`Get-PhysicalDisk` + SMART predictive status via `Get-CimInstance`).

### Added
- Shared `:CheckResult` subroutine used across the script to standardize `[PASS]` / `[FAIL]` reporting and reduce code duplication.

## [1.1.5]

- Initial release: Temp/Prefetch/DNS/Recycle Bin cleaning, browser cache cleaning, Windows.old cleanup, thumbnail/font cache cleaning, event log clearing, old downloads cleanup, disk space/largest files reports, installed programs uninstaller, disk health check, CHKDSK, task scheduling, full clean, theme switching.
