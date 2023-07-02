class UserInfoModel {
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? email;
  String? status;
  bool? profileCompleted;
  String? dateOfBirth;

  UserInfoModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.status,
      this.photoUrl,
      this.profileCompleted,
      this.dateOfBirth});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    status = json['status'];
    photoUrl = json['photoUrl'];
    profileCompleted = json['profileCompleted'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['photoUrl'] = this.photoUrl;
    data['dateOfBirth'] = this.dateOfBirth;
    data['profileCompleted'] = this.profileCompleted;
    return data;
  }
}
