class Users {
  final String id;
  String firstName;
  String lastName;
  Users({required this.id, required this.firstName, required this.lastName});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      id: json['id'], firstName: json['firstName'], lastName: json['lastName']);

  Map<String, dynamic> toMap() =>
      {"id": id, "firstName": firstName, "lastName": lastName};
}
