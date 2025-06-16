#include <iostream>
#include <string>
#include <vector>
#include <memory>

// Base class
class Ride {
protected:
    std::string rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance;
public:
    Ride(const std::string& id,
         const std::string& pickup,
         const std::string& dropoff,
         double dist)
      : rideID(id), pickupLocation(pickup),
        dropoffLocation(dropoff), distance(dist) {}

    virtual ~Ride() = default;

    // Encapsulation: distance is private, exposed via this method
    virtual double calculateFare() const {
        return distance * 1.0;
    }

    virtual void rideDetails() const {
        std::cout << "Ride " << rideID
                  << ": " << pickupLocation << " -> " << dropoffLocation
                  << ", Distance: " << distance
                  << ", Fare: $" << calculateFare()
                  << std::endl;
    }
};

// Inheritance + Polymorphism
class StandardRide : public Ride {
public:
    StandardRide(const std::string& id,
                 const std::string& pickup,
                 const std::string& dropoff,
                 double dist)
      : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() const override {
        return distance * 1.5;
    }
};

class PremiumRide : public Ride {
public:
    PremiumRide(const std::string& id,
                const std::string& pickup,
                const std::string& dropoff,
                double dist)
      : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() const override {
        return distance * 3.0;
    }
};

// Driver class with encapsulated ride list
class Driver {
private:
    std::string driverID;
    std::string name;
    double rating;
    std::vector<std::shared_ptr<Ride>> assignedRides;

public:
    Driver(const std::string& id,
           const std::string& nm,
           double rt)
      : driverID(id), name(nm), rating(rt) {}

    void addRide(std::shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        std::cout << "Driver " << driverID
                  << ": " << name
                  << " (Rating: " << rating << ")\n"
                  << "Rides:\n";
        for (const auto& r : assignedRides) {
            r->rideDetails();
        }
    }
};

// Rider class with encapsulated requested rides
class Rider {
private:
    std::string riderID;
    std::string name;
    std::vector<std::shared_ptr<Ride>> requestedRides;

public:
    Rider(const std::string& id,
          const std::string& nm)
      : riderID(id), name(nm) {}

    void requestRide(std::shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        std::cout << "Rider " << riderID
                  << ": " << name << "\n"
                  << "Requested Rides:\n";
        for (const auto& r : requestedRides) {
            r->rideDetails();
        }
    }
};

int main() {
    using RidePtr = std::shared_ptr<Ride>;

    // Polymorphic list of rides
    std::vector<RidePtr> rides {
        std::make_shared<StandardRide>("R1", "LocationA", "LocationB", 10),
        std::make_shared<PremiumRide>("P1",  "LocationC", "LocationD", 5)
    };

    Driver driver("D1", "Alice", 4.9);
    Rider  rider ("Rdr1", "Bob");

    // Assign rides
    for (auto& r : rides) {
        driver.addRide(r);
        rider.requestRide(r);
    }

    // Show info
    driver.getDriverInfo();
    std::cout << std::endl;
    rider.viewRides();

    return 0;
}
// This code demonstrates the use of OOP principles in C++
// to model a ride-sharing system with drivers and riders.
// It includes encapsulation, inheritance, polymorphism,
// and dynamic memory management using smart pointers.
// The code is structured to be clear and maintainable,