// This code calculates the mean, median, and mode of a given array of integers.
// It uses the C standard library for sorting and input/output operations.
// The mean is calculated by summing the elements and dividing by the number of elements.

#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

double mean(int arr[], int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) sum += arr[i];
    return (double)sum / size;
}

double median(int arr[], int size) {
    qsort(arr, size, sizeof(int), compare);
    if (size % 2 == 0)
        return (arr[size/2 - 1] + arr[size/2]) / 2.0;
    return arr[size/2];
}

void mode(int arr[], int size) {
    int maxCount = 0, i, j;
    for (i = 0; i < size; ++i) {
        int count = 1;
        for (j = i + 1; j < size; ++j)
            if (arr[j] == arr[i]) count++;
        if (count > maxCount) maxCount = count;
    }

    printf("Mode: ");
    for (i = 0; i < size; ++i) {
        int count = 1;
        for (j = i + 1; j < size; ++j)
            if (arr[j] == arr[i]) count++;
        if (count == maxCount) {
            printf("%d ", arr[i]);
            while (i + 1 < size && arr[i] == arr[i + 1]) i++;
        }
    }
    printf("\n");
}

int main() {
    int data[] = {1, 2, 2, 3, 4};
    int size = sizeof(data)/sizeof(data[0]);

    printf("Mean: %.2f\n", mean(data, size));
    printf("Median: %.2f\n", median(data, size));
    mode(data, size);
    return 0;
}
