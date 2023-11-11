class Car {
  String make;
  String model;
  String year;
  String fuel;
  String licensePlate;

  Car({
    required this.make,
    required this.model,
    required this.year,
    required this.fuel,
    required this.licensePlate,
  });
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      make: json['make'],
      model: json['model'],
      year: json['year'],
      fuel: json['fuel'],
      licensePlate: json['regNumber'],
    );
  }
}
