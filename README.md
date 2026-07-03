# System Cleaner (SC)

A single-file, menu-driven **Windows batch (.bat)** utility for cleaning temp files, caches, and logs, plus a set of handy system tools — disk space reports, largest-files scan, installed-programs uninstaller, disk health check, CHKDSK, and scheduled automatic cleaning.

By **Bassem Mohamed** — [hyperflow-corp.pages.dev](https://hyperflow-corp.pages.dev/)

---

## Features

- **Quick actions**: Clean Temp files, Clean Prefetch, Flush DNS, Empty Recycle Bin, Export System Info
- **Full Clean**: one-click run of all core cleaning steps with a before/after free-space report
- **Advanced Cleaning Tools**
  - Browser cache cleaner (Chrome / Edge / Firefox) — auto-detects installed browsers
  - Windows.old & old update leftovers (with DISM component store cleanup)
  - Thumbnail cache, Font cache
  - Event log clearing
  - Windows Error Reporting file cleanup
  - Old Downloads cleanup by age, with a confirmation prompt before deletion
- **System Tools**
  - Disk free space report
  - Top 10 largest files/folders
  - Installed programs manager (uninstall by name)
  - Disk health check (PowerShell `Get-PhysicalDisk` + SMART predictive status)
  - CHKDSK (read-only scan, or full scan + fix on restart)
  - Schedule automatic Full Clean (daily/weekly via Task Scheduler)
- **Optional logging** to `clean_log.txt` next to the script
- **Silent `/auto` mode** for unattended runs from Task Scheduler
- Every action reports a real **[PASS] / [FAIL]** result — nothing is assumed to succeed

---

## Requirements

- Windows 10 or 11
- Administrator privileges (the script elevates itself automatically via UAC)
- PowerShell available on `PATH` (default on all supported Windows versions)

---

## Usage

1. Download `System Cleaner.bat`.
2. Double-click to run. It will request Administrator access via UAC.
3. Use the on-screen menu to pick an action, or run **6 - FULL CLEAN** for the full routine.

### Unattended / scheduled runs

The script supports a silent flag for use with Task Scheduler:

```bat
SystemCleanerUltra.bat /auto
```

This runs a Full Clean with logging enabled and no prompts. You can set this up automatically from the in-app menu: **System Tools → Schedule Automatic Full Clean**.

---

## Disclaimer

This script performs **destructive operations**: deleting temp files, browser caches, event logs, old downloads, and optionally running `CHKDSK /f /r` (which requires a restart). Review the source before running it, and use the **Old Downloads** and **CHKDSK full scan** options with care — they include confirmation prompts for a reason.

The author provides this software "as is" with no warranty; see [LICENSE](LICENSE).

---

## Project structure

```
system-cleaner/
├── System Cleaner.bat   # the tool itself
├── README.md
├── LICENSE
├── CHANGELOG.md
└── .gitignore
```

---

## Contributing

Issues and pull requests are welcome — especially reports of commands that silently fail on your Windows build. Please describe your Windows version and, if possible, the console output.

---

## License

Released under the [MIT License](LICENSE).

---

<details>
<summary>🇪🇬 نسخة عربي</summary>

## أداة System Cleaner (SC)

أداة تنظيف وصيانة لويندوز في ملف batch واحد، بقائمة تفاعلية: تنظيف الملفات المؤقتة والكاش والسجلات، بالإضافة لأدوات نظام زي تقرير مساحة القرص، أكبر الملفات، إدارة إلغاء تثبيت البرامج، فحص صحة القرص، CHKDSK، وجدولة تنظيف تلقائي.

بواسطة **Bassem Mohamed** — [hyperflow-corp.pages.dev](https://hyperflow-corp.pages.dev/)

### المتطلبات
- ويندوز 10 أو 11
- صلاحيات المسؤول (الأداة بترفع صلاحياتها تلقائيًا)

### طريقة الاستخدام
حمّل `System Cleaner.bat` وشغّله، هيطلب صلاحيات المسؤول، واختر من القائمة العملية اللي عايزها أو استخدم **FULL CLEAN** للتنظيف الشامل.

### تنبيه
الأداة بتنفذ عمليات حذف فعلية (ملفات مؤقتة، كاش المتصفحات، سجلات الأحداث، تنزيلات قديمة)، وبعض الخيارات زي CHKDSK الكامل بتحتاج إعادة تشغيل. راجع الكود قبل التشغيل على أي جهاز مهم.

الترخيص: [MIT](LICENSE)

</details>
