import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/user_controller.dart';
import 'package:task1/screen/album_screen.dart';
import 'package:task1/screen/date_and_time_screen.dart';
import 'package:task1/screen/edit_user_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    _userController.getUserData();
    super.initState();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions:  [
          InkWell(
            onTap: (){
              Get.to(const DateAndTimeScreen());
            },

            child: const Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Icon(Icons.access_time_rounded),
            ),
          )
        ],
      ),
      body: Obx(
        () => (_userController.isLoading.value == false)
            ? _userController.isError.value == true
                ? Center(
                    child: Text(_userController.errorMessage.value.toString()),
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: _userController.userList.isEmpty
                        ? const Center(child: Text("User not Found"))
                        : ListView.builder(
                            itemCount: _userController.userList.length,
                            itemBuilder: (context, index) {
                              final user = _userController.userList[index];
                              return Card(
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                     Get.to( AlubumScreen(userId: user.id.toString() ,));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.account_circle_rounded),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(user.name ?? ''),
                                            Text(user.email ?? ''),
                                          ],
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                EditUserScreen(
                                                  userId: user.id
                                                      .toString() ??
                                                      "",
                                                ));
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
