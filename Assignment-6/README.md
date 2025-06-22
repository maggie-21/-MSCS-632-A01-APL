# Parallel Data Processing System — Java & Go

A small project that showcases two different concurrency models:

* **Java** — Classic shared-memory threads managed by an `ExecutorService`.
* **Go** — Lightweight goroutines that communicate over channels (CSP style).

Workers pull tasks from a queue, simulate work, and persist the result list to disk.

---

## ✨ Features

| Capability                              | Java | Go |
|-----------------------------------------|:----:|:--:|
| Shared, thread-safe task queue          | ✔️ (`LinkedBlockingQueue`) | ✔️ (buffered `chan Task`) |
| Multiple concurrent workers             | ✔️ (`ExecutorService`) | ✔️ (goroutines) |
| Result aggregation without races        | ✔️ (`synchronizedList`) | ✔️ (result channel) |
| Graceful shutdown (no deadlocks)        | ✔️ `CountDownLatch`     | ✔️ `sync.WaitGroup` |
| Robust error / panic handling           | ✔️ `try-catch`          | ✔️ `if err != nil` + `defer` |
| Console logging of every step           | ✔️ `java.util.logging`  | ✔️ `log.Printf` |
| Results written to text files           | `results_java.txt`      | `results_go.txt` |

---

## 🗂 Project Layout

data-processing-system/
├── java/
│ └── DataProcessingSystem.java
├── go/
│ └── main.go
├── results_java.txt # auto-generated
├── results_go.txt # auto-generated
└── README.md

---

## 🚀 How to Run

### Prerequisites
* **Java 8** (or newer) in your `PATH`
* **Go 1.20** (or newer) in your `PATH`

### 1. Java version

```bash
cd java
javac DataProcessingSystem.java
java DataProcessingSystem
```
On success you’ll see INFO logs in the terminal and a new file:
    
    ../results_java.txt
### 2. Go version
```bash
cd go
go run main.go
```
Likewise, the run produces console logs plus:

bash
../results_go.txt

Both executables default to 20 tasks and 4 workers; tweak the constants at
the top of each file if you’d like different values.

## Sample Console Output
1 Java (excerpt)
```arduino

Jun 20 19:44:30 INFO Worker-1 started Task 1
Jun 20 19:44:30 INFO Worker-3 started Task 3
```
Jun 20 19:44:31 INFO All tasks processed. Results written to results_java.txt
2 Go (excerpt)
```swift

2025/06/21 00:01:50 worker-2 started task 1
2025/06/21 00:01:50 worker-1 started task 4
```
2025/06/21 00:01:52 All tasks processed. Results written to results_go.txt

## Sample Result Files
results_java.txt (first 8 lines)
```arduino

Task 3 processed by Worker-3
Task 2 processed by Worker-2
Task 4 processed by Worker-4
Task 1 processed by Worker-1
Task 7 processed by Worker-3
Task 5 processed by Worker-4
Task 6 processed by Worker-2
Task 8 processed by Worker-1
```


results_go.txt (first 8 lines)
``` arduino

Task 4 processed by worker-1
Task 2 processed by worker-3
Task 1 processed by worker-2
Task 3 processed by worker-4
Task 6 processed by worker-4
Task 8 processed by worker-2
Task 7 processed by worker-3
Task 5 processed by worker-1
