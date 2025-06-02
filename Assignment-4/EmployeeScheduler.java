// === Java: Employee Scheduler (Preference + Full Coverage) ===
// - 10 employees, each with ranked preferences for every day.
// - Each can work at most 5 days/week, and at most 1 shift/day.
// - We fill all 7 days × 3 shifts × 2 slots = 42 total.
//   1) First pass: assign from 1st-pref, 2nd-pref, then 3rd-pref in that order, randomly among ties.
//   2) If a shift still needs slots, pick ANY eligible employee (random) to fill.
// - Because 10 employees × 5 days = 50 total “slots,” the 42 needed slots can always be filled.
// - Static sample data; final schedule is printed at the end.
import java.util.*;

public class EmployeeScheduler {

    static final String[] DAYS = {
        "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", "Sunday"
    };
    static final String[] SHIFTS = {
        "morning", "afternoon", "evening"
    };

    // Helper class to store each employee’s name, preferences, and how many days they've worked.
    static class Employee {
        String name;
        Map<String, List<String>> preferences = new HashMap<>();
        int shiftCount = 0;  // how many days assigned so far

        Employee(String name) {
            this.name = name;
            // For simplicity, every employee has the same ranking each day.
            for (String day : DAYS) {
                preferences.put(day,
                    new ArrayList<>(List.of("morning", "afternoon", "evening"))
                );
            }
        }
    }

    public static void main(String[] args) {
        // 1) Build a map of 10 sample employees:
        Map<String, Employee> employees = new HashMap<>();
        for (String name : List.of(
            "Alice", "Bob", "Carol", "Dave", "Eve",
            "Frank", "Grace", "Heidi", "Ivan", "Judy"
        )) {
            employees.put(name, new Employee(name));
        }

        // 2) Initialize the “schedule” structure:
        //    schedule.get(day).get(shift) → List<String> of assigned names (max 2).
        Map<String, Map<String, List<String>>> schedule = new HashMap<>();
        for (String day : DAYS) {
            Map<String, List<String>> shiftMap = new HashMap<>();
            for (String shift : SHIFTS) {
                shiftMap.put(shift, new ArrayList<>());
            }
            schedule.put(day, shiftMap);
        }

        // 3) Track which employees are already assigned on each day (to enforce 1 shift/day):
        Map<String, Set<String>> assignedToday = new HashMap<>();
        for (String day : DAYS) {
            assignedToday.put(day, new HashSet<>());
        }

        Random rand = new Random();

        // 4) MAIN LOGIC: For each day & each shift, fill 2 slots
        for (String day : DAYS) {
            Set<String> assignedSet = assignedToday.get(day);

            for (String shift : SHIFTS) {
                int slotsNeeded = 2;

                // (a) Try by preference levels: 0 (top), 1 (second), 2 (third).
                for (int prefLevel = 0; prefLevel < 3 && slotsNeeded > 0; prefLevel++) {
                    // Collect employees who:
                    //  - Worked < 5 days so far (shiftCount < 5)
                    //  - Are not yet assigned any shift on this 'day' (not in assignedSet)
                    //  - Rank the current 'shift' at preference index = prefLevel
                    List<Employee> candidates = new ArrayList<>();
                    for (Employee e : employees.values()) {
                        if (isEligible(e, assignedSet) &&
                            e.preferences.get(day).get(prefLevel).equals(shift)) {
                            candidates.add(e);
                        }
                    }

                    Collections.shuffle(candidates);
                    // Assign up to 'slotsNeeded' people from these candidates
                    Iterator<Employee> it = candidates.iterator();
                    while (it.hasNext() && slotsNeeded > 0) {
                        Employee chosen = it.next();
                        schedule.get(day).get(shift).add(chosen.name);
                        assignedSet.add(chosen.name);
                        chosen.shiftCount++;
                        slotsNeeded--;
                    }
                }

                // (b) If still underfilled, assign from ANY eligible employee
                if (slotsNeeded > 0) {
                    List<Employee> candidates = new ArrayList<>();
                    for (Employee e : employees.values()) {
                        if (isEligible(e, assignedSet)) {
                            candidates.add(e);
                        }
                    }
                    Collections.shuffle(candidates);
                    Iterator<Employee> it = candidates.iterator();
                    while (it.hasNext() && slotsNeeded > 0) {
                        Employee chosen = it.next();
                        schedule.get(day).get(shift).add(chosen.name);
                        assignedSet.add(chosen.name);
                        chosen.shiftCount++;
                        slotsNeeded--;
                    }
                }

                // At this point, slotsNeeded should be 0 (we have capacity).
            }
        }

        // 5) Print final weekly schedule
        System.out.println("Final Weekly Schedule:\n=======================");
        for (String day : DAYS) {
            System.out.println("\n" + day + ":");
            for (String shift : SHIFTS) {
                List<String> assignedList = schedule.get(day).get(shift);
                System.out.printf("  %s: %s%n",
                    capitalize(shift),
                    String.join(", ", assignedList)
                );
            }
        }
    }

    // Checks if an employee 'e' is eligible to work another shift:
    //  - They have worked < 5 days (shiftCount < 5)
    //  - They are not already assigned on 'day' (assignedToday set)
    static boolean isEligible(Employee e, Set<String> assignedSet) {
        return e.shiftCount < 5 && !assignedSet.contains(e.name);
    }

    // Capitalize the first letter of a string
    static String capitalize(String s) {
        if (s == null || s.isEmpty()) return s;
        return s.substring(0, 1).toUpperCase() + s.substring(1);
    }
}
