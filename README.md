# CIDR to IP List Script

This Bash script expands a given CIDR notation (e.g., `192.168.1.0/24`) into all the IP addresses within that range.  
It supports any valid IPv4 CIDR and prints either the full list (including network and broadcast) or just the usable host addresses.

---

## 📌 Features
- Converts CIDR notation into a list of IP addresses.
- Works for small and large ranges (e.g., `/30` up to `/13`).
- Option to include or exclude network and broadcast addresses.
- Pure Bash implementation — no external dependencies required.

---

## ⚙️ Usage

```bash
./cidr.sh <CIDR>
