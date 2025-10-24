| Container Type           | Role                                                                 | Why It Exists                                                 |
| ------------------------ | -------------------------------------------------------------------- | ------------------------------------------------------------- |
| **Main container**       | Runs your actual app (like a web API)                                | The core logic of your service                                |
| **Init container**       | Prepares the environment before your app starts                      | Ensures your app starts with correct data or dependencies     |
| **Sidecar container**    | Runs alongside your app, continuously providing a supporting service | Offloads secondary tasks (like cache refresh, log collection) |
| **Privileged container** | Has **extra permissions** to perform system-level operations         | Needed for low-level networking, storage, or monitoring tasks |

---

| Task                           | Type of Container          |
| ------------------------------ | -------------------------- |
| Run your app (e.g., a website) | Main container             |
| Initialize SSL certificates    | Init container             |
| Update application cache       | Sidecar container          |
| Run a network monitoring agent | Privileged container       |

---

| Container Type       | Analogy                                                        |
| -------------------- | -------------------------------------------------------------- |
| Main container       | The chef — cooks the main meal.                                |
| Init container       | The prep cook — sets up ingredients before cooking starts.     |
| Sidecar container    | The assistant — keeps the kitchen stocked and clean.           |
| Privileged container | The electrician — can touch the building’s wiring if needed. ⚡ |

