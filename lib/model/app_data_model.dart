class AppData {
  String id;
  String icon;
  String title;
  String disc;
  String color;

  AppData({
    required this.id,
    required this.icon,
    required this.title,
    required this.disc,
    required this.color,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      id: json['id'],
      icon: json['icon'],
      title: json['title'],
      disc: json['disc'],
      color: json['color'],
    );
  }
}
