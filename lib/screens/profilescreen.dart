// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopin_app/model/usermodel.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/widgets/mybutton.dart';

import '../widgets/mytextformField.dart';
import '../widgets/notification_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Firebase User
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
    }
  }

  UserModel? userModel;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController userName = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  bool isMale = false;
  void vaildation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      const SnackBar(
        content: Text("All Fields Are Empty"),
      );
    } else if (userName.text.isEmpty) {
      const SnackBar(
        content: Text("Username Is Empty "),
      );
    } else if (userName.text.length < 6) {
      const SnackBar(
        content: Text("Username Must Be more than 6 character"),
      );
    } else if (phoneNumber.text.length < 10 || phoneNumber.text.length > 11) {
      const SnackBar(
        content: Text("Phone Number Must Be 11"),
      );
    } else {
      userDetailUpdate();
    }
  }

  File? _pickedImage;

  PickedFile? _image;
  Future<void> getImage({required ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    setState(() {
      _pickedImage = File(_image!.path);
    });
  }

  String userUid = "";

  Future<String> _uploadImage({File? image}) async {
    String url;
    Reference storageReference =
        FirebaseStorage.instance.ref().child("userImage/$userUid");
    UploadTask uploadTask = storageReference.putFile(image!);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {
      url = storageReference.getDownloadURL() as String;
    }).catchError((onError) {
      print(
        onError,
      );
    });
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User? myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser!.uid;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("User").doc(userUid).update({
      "UserName": userName.text,
      "userGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
      "userImage": imageMap,
      "userAddress": address.text
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _buildSingleContainer(
      {Color? color, String startText = "", String endText = ""}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: const TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    address = TextEditingController(text: userModel?.userAddress);
    userName = TextEditingController(text: userModel?.userName);
    phoneNumber = TextEditingController(text: userModel?.userPhoneNumber);
    if (userModel?.userGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: "${loggedInUser.userName}",
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: "${loggedInUser.userEmail}",
            startText: "Email",
          ),
          _buildSingleContainer(
            endText: "${loggedInUser.userGender}",
            startText: "Gender",
          ),
          _buildSingleContainer(
            endText: "${loggedInUser.userPhoneNumber}",
            startText: "Phone Number",
          ),
          _buildSingleContainer(
            endText: "${loggedInUser.userAddress}",
            startText: "Address",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFieldsPart() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            textInputAction: TextInputAction.next,
            labelText: "Enter your username",
            hintText: "Username",
            textInputType: TextInputType.name,
            controller: userName,
          ),
          _buildSingleContainer(
            color: Colors.grey[300],
            endText: "${loggedInUser.userEmail}",
            startText: "Email",
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: _buildSingleContainer(
              color: Colors.white,
              endText: isMale == true ? "Male" : "Female",
              startText: "Gender",
            ),
          ),
          MyTextFormField(
            textInputAction: TextInputAction.next,
            labelText: "Enter your phone number",
            hintText: "Phone Number",
            textInputType: TextInputType.phone,
            controller: phoneNumber,
          ),
          MyTextFormField(
            textInputAction: TextInputAction.done,
            labelText: "Enter your address",
            hintText: "Address",
            textInputType: TextInputType.streetAddress,
            controller: address,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const HomePage(),
                      ),
                    );
                  });
                },
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? const NotificationButton()
              : IconButton(
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                  onPressed: () {
                    vaildation();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var myDoc = snapshot.data?.docs;
                      for (var checkDocs in myDoc!) {
                        if (checkDocs.data()["UserId"] == userUid) {
                          userModel = UserModel(
                            userId: checkDocs.data()[''],
                            userEmail: checkDocs.data()["userEmail"],
                            userImage: checkDocs.data()["userImage"],
                            userAddress: checkDocs.data()["userAddress"],
                            userGender: checkDocs.data()["userGender"],
                            userName: checkDocs.data()["userName"],
                            userPhoneNumber: checkDocs.data()["userNumber"],
                            userPassword: checkDocs.data()["userPassword"],
                          );
                        }
                      }
                      return Container(
                        height: 603,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircleAvatar(
                                        maxRadius: 65,
                                        backgroundImage: AssetImage(
                                          "images/userImage.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                edit == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                220,
                                            top: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                110),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              myDialogBox(context);
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Color(0xff746bc9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: edit == true
                                          ? _buildTextFormFieldsPart()
                                          : _buildContainerPart(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: edit == false
                                    ? MyButton(
                                        name: "Edit Profile",
                                        onPressed: () {
                                          setState(() {
                                            edit = true;
                                          });
                                        },
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
