class UserModel {
  String userName,
      userId,
      userPassword,
      userEmail,
      userGender,
      userPhoneNumber,
      userImage,
      userAddress;
  UserModel(
      {required this.userEmail,
      required this.userId,
      required this.userPassword,
      required this.userImage,
      required this.userAddress,
      required this.userGender,
      required this.userName,
      required this.userPhoneNumber});

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
