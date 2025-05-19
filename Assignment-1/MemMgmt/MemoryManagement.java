public class MemoryManagement {
    public static void main(String[] args) {
        int[] data = new int[]{1, 2, 3, 4, 5}; // heap allocation
        printData(data);
        data = null; // Eligible for garbage collection
        System.gc(); // Hint to JVM to run GC (optional)
    }

    public static void printData(int[] arr) {
        for (int i : arr) {
            System.out.print(i + " ");
        }
    }
}
