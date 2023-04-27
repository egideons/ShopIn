class UserModel {
  String? userName,
      userId,
      userPassword,
      userEmail,
      userGender,
      userPhoneNumber,
      userImage,
      userAddress;
  UserModel(
      {this.userEmail,
      this.userId,
      this.userPassword,
      this.userImage,
      this.userAddress,
      this.userGender,
      this.userName,
      this.userPhoneNumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        userId: map['userId'],
        userEmail: map['userEmail'],
        userPhoneNumber: map['userPhoneNumber'],
        userPassword: map['userPassword'],
        userAddress: map['userAddress'],
        userImage: map['userImage'],
        userGender: map['userGender'],
        userName: map['userName']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'userPhoneNumber': userPhoneNumber,
      'userAddress': userAddress,
      'userImage': userImage,
      'userName': userName,
      'userGender': userGender,
    };
  }
}
