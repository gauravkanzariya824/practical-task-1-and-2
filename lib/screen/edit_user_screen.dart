import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/edit_user_details_controller.dart';
import 'package:task1/controller/user_controller.dart';

class EditUserScreen extends StatefulWidget {
  final String userId;
  const EditUserScreen({Key? key, required this.userId}) : super(key: key);
  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final EditUserController editUserController = Get.put(EditUserController());
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    editUserController.getUserDetails(widget.userId);
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
        title: const Text('User Details'),
      ),
      body: Obx(() {
        if (editUserController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (editUserController.isError.value) {
          return Center(
              child: Text('Error: ${editUserController.errorMessage.value}'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: editUserController.nameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Name', border: InputBorder.none),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: editUserController.usernameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Username', border: InputBorder.none),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: editUserController.emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Email', border: InputBorder.none),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: editUserController.phoneController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Phone', border: InputBorder.none),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: editUserController.websiteController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Website', border: InputBorder.none),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: editUserController.companyController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Company', border: InputBorder.none),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50, // Set a custom height
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add User'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                          labelText: 'Name'),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: usernameController,
                                      decoration: const InputDecoration(
                                          labelText: 'Username'),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                          labelText: 'Email'),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: phoneController,
                                      decoration: const InputDecoration(
                                          labelText: 'Phone'),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: websiteController,
                                      decoration: const InputDecoration(
                                          labelText: 'Website'),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: companyController,
                                      decoration: const InputDecoration(
                                          labelText: 'Company'),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          child: Text('Submit'),
                                          onPressed: () async {
                                            try {
                                              var mapData = <String, dynamic>{};
                                              mapData['name'] =
                                                  nameController.text;
                                              mapData['username'] =
                                                  usernameController.text;
                                              mapData['email'] =
                                                  emailController.text;
                                              mapData['phone'] =
                                                  phoneController.text;
                                              mapData['website'] =
                                                  websiteController.text;
                                              mapData['company'] = {
                                                "name": companyController.text
                                              };
                                              if (nameController.text.isEmpty ||
                                                  usernameController
                                                      .text.isEmpty ||
                                                  emailController
                                                      .text.isEmpty ||
                                                  phoneController
                                                      .text.isEmpty ||
                                                  websiteController
                                                      .text.isEmpty ||
                                                  companyController
                                                      .text.isEmpty) {
                                                Get.snackbar('Error !!',
                                                    'Enter All Details',
                                                    snackPosition:
                                                        SnackPosition.TOP);
                                              } else {
                                                await _userController.addUser(
                                                  mapData,
                                                );
                                                Navigator.of(context).pop();
                                              }
                                            } catch (e) {
                                              debugPrint(e.toString());
                                            }
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 18, // Font size
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Add User'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50, // Set a custom height
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Edit User'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller:
                                              editUserController.nameController,
                                          decoration: const InputDecoration(
                                              labelText: 'Name'),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: editUserController
                                              .usernameController,
                                          decoration: const InputDecoration(
                                              labelText: 'Username'),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: editUserController
                                              .emailController,
                                          decoration: const InputDecoration(
                                              labelText: 'Email'),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: editUserController
                                              .phoneController,
                                          decoration: const InputDecoration(
                                              labelText: 'Phone'),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: editUserController
                                              .websiteController,
                                          decoration: const InputDecoration(
                                              labelText: 'Website'),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: editUserController
                                              .companyController,
                                          decoration: const InputDecoration(
                                              labelText: 'Company'),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Edit'),
                                              onPressed: () async {
                                                try {
                                                  var mapData =
                                                      <String, dynamic>{};
                                                  mapData['name'] =
                                                      editUserController
                                                          .nameController.text;
                                                  mapData['username'] =
                                                      editUserController
                                                          .usernameController
                                                          .text;
                                                  mapData['email'] =
                                                      editUserController
                                                          .emailController.text;
                                                  mapData['phone'] =
                                                      editUserController
                                                          .phoneController.text;
                                                  mapData['website'] =
                                                      editUserController
                                                          .websiteController
                                                          .text;
                                                  mapData['company'] = {
                                                    "name": editUserController
                                                        .companyController.text
                                                  };
                                                  await editUserController
                                                      .updateUserDetails(
                                                          mapData,
                                                          context,
                                                          widget.userId);
                                                  Navigator.of(context).pop();
                                                } catch (e) {
                                                  debugPrint(e.toString());
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 18, // Font size
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Edit'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await editUserController
                                  .deleteUser(widget.userId.toString());
                              Future.delayed(const Duration(milliseconds: 1),
                                  () {
                                Navigator.pop(context);
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                          ),
                          child: const Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
