class AuthModel {
  String displayName;
  String profilePic;
  String email;

  AuthModel(
      {required this.displayName,
      required this.email,
      required this.profilePic});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      displayName: json['displayName'],
      profilePic: json['profilePic'],
      email: json['email']);

  Map<String, dynamic> toMap() =>
      {"displayName": displayName, "profilePic": profilePic, "email": email};
}

class AdditionalInfo {
  String? batch;
  String? branch;
  String? currentSemester;
  String? yop;
  String? currentYear;
  List? social;

  AdditionalInfo(
      {this.batch,
      this.branch,
      this.currentSemester,
      this.currentYear,
      this.yop,
      this.social});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        batch: json['batch'],
        branch: json['branch'],
        currentSemester: json['currentSemester'],
        currentYear: json['currentYear'],
        yop: json['yop'],
        social: json['social'],
      );

  Map<String, dynamic> toMap() => {
        "batch": batch,
        "branch": branch,
        "currentSemester": currentSemester,
        "currentYear": currentYear,
        "yop": yop,
        "social": social,
      };
}
