class SignupSavepDataFirebase {
  String? userId;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? email;
  String? status;
  String? createAt;
  String? phoneNumber;
  String? countryCode;
  int? score;
  bool? isVerified;
  bool? socialLogin;
  String? loggedInStatus;
  String? currentSubscription;
  String? memberType;
  bool? profileCompleted;

  SignupSavepDataFirebase(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.status,
      this.phoneNumber,
      this.createAt,
      this.score,
      this.photoUrl,
      this.countryCode,
      this.socialLogin,
      this.isVerified,
      this.loggedInStatus,
      this.memberType,
      this.profileCompleted,
      this.currentSubscription});

  SignupSavepDataFirebase.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    status = json['status'];
    createAt = json['createAt'];
    score = json['score'];
    socialLogin = json['socialLogin'];
    photoUrl = json['photoUrl'];
    phoneNumber = json['phoneNumber'];
    isVerified = json['isVerified'];
    countryCode = json['countryCode'];
    loggedInStatus = json['loggedInStatus'];
    currentSubscription = json['currentSubscription'];
    profileCompleted = json['profileCompleted'];
    memberType = json['memberType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['socialLogin'] = this.socialLogin;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    data['score'] = this.score;
    data['photoUrl'] = this.photoUrl;
    data['countryCode'] = this.countryCode;
    data['isVerified'] = this.isVerified;
    data['loggedInStatus'] = this.loggedInStatus;
    data['currentSubscription'] = this.currentSubscription;
    data['memberType'] = this.memberType;
    data['profileCompleted'] = this.profileCompleted;
    return data;
  }
}
