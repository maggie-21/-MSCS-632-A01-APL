package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sync"
	"time"
)

// Task represents the work payload (extend freely).
type Task struct{ ID int }

// worker consumes tasks and pushes results.
func worker(id int, tasks <-chan Task, results chan<- string, wg *sync.WaitGroup) {
	defer wg.Done()
	for task := range tasks {
		log.Printf("worker-%d started task %d", id, task.ID)
		time.Sleep(300 * time.Millisecond) // simulated compute
		results <- fmt.Sprintf("Task %d processed by worker-%d", task.ID, id)
		log.Printf("worker-%d finished task %d", id, task.ID)
	}
}

func main() {
	const (
		numWorkers = 4
		numTasks   = 20
	)

	tasks := make(chan Task, numTasks)
	results := make(chan string, numTasks)

	var wg sync.WaitGroup
	for i := 1; i <= numWorkers; i++ {
		wg.Add(1)
		go worker(i, tasks, results, &wg)
	}

	// Feed tasks
	for i := 1; i <= numTasks; i++ {
		tasks <- Task{ID: i}
	}
	close(tasks) // no more work

	go func() {
		wg.Wait()
		close(results)
	}()

	// Persist results
	file, err := os.Create("results_go.txt")
	if err != nil {
		log.Fatalf("cannot create results file: %v", err)
	}
	defer file.Close()
	w := bufio.NewWriter(file)
	for res := range results {
		_, _ = w.WriteString(res + "\n")
	}
	_ = w.Flush()
	log.Println("All tasks processed. Results written to results_go.txt")
}
