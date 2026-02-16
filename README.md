# Azan

This is the monorepo for the Azan project, containing both the backend (AzanScheduler) and frontend (AzanUI) applications for managing and scheduling Azan (Islamic prayer calls).


![Build Status](https://img.shields.io/github/actions/workflow/status/MoRefaie/Azan/Azan-Build.yml?branch=main)
![License](https://img.shields.io/github/license/MoRefaie/Azan)

## Git Repositories

- **Monorepo (this repo):** [Azan Monorepo](https://github.com/MoRefaie/Azan)
- **Backend:** [AzanScheduler](https://github.com/MoRefaie/AzanScheduler)
- **Frontend:** [AzanUI](https://github.com/MoRefaie/AzanUI)

## Architecture & Flow

```
+-------------------+      +-------------------+      +-------------------+
|   Azan UI (Web)   | <--> |    FastAPI API    | <--> |   Scheduler Core  |
+-------------------+      +-------------------+      +-------------------+
        ^                        ^                            ^
        |                        |                            |
        +------------------------+----------------------------+
                         System Tray (pystray)
```

- **Azan UI (Web):** Modern React dashboard ([AzanUI](https://github.com/MoRefaie/AzanUI))
- **FastAPI API:** Backend API ([AzanScheduler](https://github.com/MoRefaie/AzanScheduler))
- **Scheduler Core:** Handles prayer time logic and notifications
- **System Tray:** Native integration for quick access and notifications

## Structure

- `AzanScheduler/` — Python FastAPI backend for scheduling, configuration, and system tray integration.
- `AzanUI/` — Modern React (Vite, TypeScript, Tailwind) frontend dashboard for managing AzanScheduler.

## Quick Start

Clone the repo:
```bash
$ git clone https://github.com/MoRefaie/Azan.git
$ cd Azan
```

### Backend (AzanScheduler)
See [`AzanScheduler/README.md`](AzanScheduler/README.md) for backend setup and usage.

### Frontend (AzanUI)
See [`AzanUI/README.md`](AzanUI/README.md) for frontend setup and usage.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for contribution guidelines. Contributions to both backend and frontend are welcome!

## License

This project is licensed under the MIT License. See [License.txt](License.txt).

## Issues & Support

- For backend issues, see the [AzanScheduler](AzanScheduler/) directory.
- For frontend issues, see the [AzanUI](AzanUI/) directory.
- Open an issue or pull request for help or suggestions.

---

For more details, see the code and documentation in each subproject.
