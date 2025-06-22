import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Multi-threaded data-processing demo.
 * ---------------------------------------------------------------
 *  • Shared queue  : LinkedBlockingQueue<Task>
 *  • Worker model  : Fixed pool via ExecutorService
 *  • Results store : thread-safe List<String>
 *  • Graceful exit : CountDownLatch + executor.shutdown()
 */
public class DataProcessingSystem {

    private static final Logger LOG = Logger.getLogger(DataProcessingSystem.class.getName());

    /** A trivial task payload – extend as needed. */
    private static class Task {
        final int id;
        Task(int id) { this.id = id; }
    }

    /** Thread-safe FIFO work queue. */
    private final BlockingQueue<Task> queue = new LinkedBlockingQueue<>();

    /** Shared result sink. */
    private final List<String> results = Collections.synchronizedList(new ArrayList<>());

    /** Worker runnable. */
    private class Worker implements Runnable {
        private final int workerId;
        private final CountDownLatch doneLatch;

        Worker(int workerId, CountDownLatch doneLatch) {
            this.workerId = workerId;
            this.doneLatch = doneLatch;
        }

        @Override
        public void run() {
            try {
                while (true) {
                    Task task = queue.poll(100, TimeUnit.MILLISECONDS); // graceful finish when queue empty
                    if (task == null) break;     // no more work
                    LOG.info(() -> "Worker-" + workerId + " started Task " + task.id);
                    // --- Simulated work ------------------------------------
                    try { Thread.sleep(Duration.ofMillis(300)); }   // compute
                    catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();         // preserve interrupt flag
                        LOG.log(Level.WARNING, "Worker interrupted", ie);
                        break;
                    }
                    // --- Record result -------------------------------------
                    results.add("Task " + task.id + " processed by Worker-" + workerId);
                    LOG.info(() -> "Worker-" + workerId + " completed Task " + task.id);
                }
            } catch (Exception ex) {
                LOG.log(Level.SEVERE, "Unhandled exception in worker-" + workerId, ex);
            } finally {
                doneLatch.countDown();
            }
        }
    }

    /** Launches the demo. */
    public void start(int numWorkers, int numTasks) throws InterruptedException, IOException {
        // preload queue
        for (int i = 1; i <= numTasks; i++) queue.add(new Task(i));

        CountDownLatch doneLatch = new CountDownLatch(numWorkers);
        ExecutorService pool = Executors.newFixedThreadPool(numWorkers);

        for (int i = 1; i <= numWorkers; i++) pool.submit(new Worker(i, doneLatch));

        doneLatch.await();                 // wait for all workers to finish
        pool.shutdown();                   // free resources
        Files.write(Path.of("results_java.txt"), results);   // persist
        LOG.info("All tasks processed. Results written to results_java.txt");
    }

    public static void main(String[] args) {
        try {
            new DataProcessingSystem().start(4, 20);
        } catch (IOException | InterruptedException ex) {
            LOG.log(Level.SEVERE, "Fatal error in driver", ex);
            Thread.currentThread().interrupt();
        }
    }
}
