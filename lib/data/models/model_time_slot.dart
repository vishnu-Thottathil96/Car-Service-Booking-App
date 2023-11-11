class SlotItem {
  final String time;
  bool isSelected;
  bool isBooked;

  SlotItem(
      {required this.time, this.isSelected = false, this.isBooked = false});
}

class SlotDataModel {
  String? slotId;
  String dateTime;
  String time;
  bool isBooked;
  SlotDataModel(
      {this.slotId,
      required this.dateTime,
      required this.isBooked,
      required this.time});
  factory SlotDataModel.fromJson(Map<String, dynamic> json) {
    return SlotDataModel(
        slotId: json['slotId'],
        dateTime: json['date'],
        isBooked: json['isBooked'],
        time: json['time']);
  }
}
