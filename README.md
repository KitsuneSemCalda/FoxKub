# FoxKub

FoxKub is a customizable configuration script for [Fedora Linux](https://pt.wikipedia.org/wiki/Fedora_Linux) designed to make a better experience with Fedora.

This script is tailored for beginners, intermediary and advanced users who want a minimal system with the basic fedora enviroment without the bloat.

## Features

- **Kernel Optimization**: Custom some kernel configurations to reduce latency and improve responsiviness.
- **Jemalloc Allocator:** Replaces the default allocator with [Jemalloc](https://en.wikipedia.org/wiki/C_dynamic_memory_allocation#FreeBSD's_and_NetBSD's_jemalloc) for better memory management and improved performance.
- **System-oomd integration:** Adds `systemd-oomd` for better handling of out-of-memory scenarios, preveting crashes and maintainly system stability.
- **Minimal Setup Service**: Disable unnecessary services by default, ensuring lower resource consumption and faster boot times.
- **Simple, Flexible Setup:** Foxkub is designed to be easy to use with customizable settings to suit different user needs, from casual users to advanced users.
