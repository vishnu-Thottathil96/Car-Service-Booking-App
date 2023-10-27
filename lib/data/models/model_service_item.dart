class ServiceItem {
  final String heading;
  final String imagePath;
  bool isSelected;

  ServiceItem({
    required this.heading,
    required this.imagePath,
    this.isSelected = false,
  });
}
