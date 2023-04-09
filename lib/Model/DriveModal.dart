class DriveModal {
  final String? id;
  String name;
  String? mimeType;
  String? type;
  double? size;
  // String lastName;
  DriveModal(
      {this.id, required this.name, this.mimeType, this.type, this.size});

  factory DriveModal.fromJson(Map<String, dynamic> json) => DriveModal(
      id: json['id'],
      name: json['name'],
      mimeType: json['mimeType'],
      type: json['type'],
      size: json['size']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "mimeType": mimeType,
        "type": type,
        "size": size
      };
}
