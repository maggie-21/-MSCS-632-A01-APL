class StatisticsCalculator:
    def __init__(self, data):
        self.data = data

    def mean(self):
        return sum(self.data) / len(self.data)

    def median(self):
        sorted_data = sorted(self.data)
        n = len(sorted_data)
        if n % 2 == 0:
            return (sorted_data[n//2 - 1] + sorted_data[n//2]) / 2
        return sorted_data[n//2]

    def mode(self):
        freq = {}
        for num in self.data:
            freq[num] = freq.get(num, 0) + 1
        max_count = max(freq.values())
        return [k for k, v in freq.items() if v == max_count]

if __name__ == "__main__":
    data = [1, 2, 2, 3, 4]
    stats = StatisticsCalculator(data)
    print("Mean:", stats.mean())
    print("Median:", stats.median())
    print("Mode:", stats.mode())
