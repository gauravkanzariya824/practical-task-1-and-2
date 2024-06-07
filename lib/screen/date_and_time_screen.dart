import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/data_and_time_controller.dart';
import 'package:task1/screen/user_screen.dart';

class DateAndTimeScreen extends StatefulWidget {
  const DateAndTimeScreen({Key? key}) : super(key: key);

  @override
  State<DateAndTimeScreen> createState() => _DateAndTimeScreenState();
}

class _DateAndTimeScreenState extends State<DateAndTimeScreen> {
  final DateController dateController = Get.put(DateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Collection '),
      ),
      body: Center(
        child: Obx(() {
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Collection Date & Time",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        dateController.selectToday();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: dateController.selectedDateString ==
                                  dateController.today
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Today\n${dateController.today}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        dateController.selectTomorrow();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: dateController.selectedDateString ==
                                  dateController.tomorrow
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Tomorrow\n${dateController.tomorrow}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: dateController.selectedDate.value,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null &&
                            picked != dateController.selectedDate.value) {
                          dateController.selectDate(picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: dateController.selectedDateString !=
                                      dateController.today &&
                                  dateController.selectedDateString !=
                                      dateController.tomorrow
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Select Date\n${dateController.selectedDateString}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Morning",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                items: dateController.morningSlot
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dateController
                                            .selecteMorningSlotTime.isEmpty
                                        ? 'Select Time '
                                        : dateController
                                            .selecteMorningSlotTime.value,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: const SizedBox(),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dateController.selectMorning(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Afternoon",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                items: dateController.afterNoonSlot
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dateController
                                            .selecteafterNoonSlotTime.isEmpty
                                        ? 'Select Time '
                                        : dateController
                                            .selecteafterNoonSlotTime.value,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: const SizedBox(),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dateController.selectAfterNoon(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  ],
                ),


                /// delivery

                const Text(
                  "Select Delivery Date & Time",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        dateController.selectTodayDelivery();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: dateController.selectedDateStringDelivery ==
                                  dateController.todayDelivery
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Today\n${dateController.todayDelivery}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        dateController.selectTomorrowDelivery();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: dateController.selectedDateStringDelivery ==
                                  dateController.tomorrowDelivery
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Tomorrow\n${dateController.tomorrowDelivery}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate:
                              dateController.selectedDateDelivery.value,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null &&
                            picked !=
                                dateController.selectedDateDelivery.value) {
                          dateController.selectDateDelivery(picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: dateController.selectedDateStringDelivery !=
                                      dateController.todayDelivery &&
                                  dateController.selectedDateStringDelivery !=
                                      dateController.tomorrowDelivery
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Select Date\n${dateController.selectedDateStringDelivery}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Morning",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                items: dateController.morningSlotDelivery
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dateController
                                            .selecteMorningSlotTimeDelivery
                                            .isEmpty
                                        ? 'Select Time '
                                        : dateController
                                            .selecteMorningSlotTimeDelivery
                                            .value,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: const SizedBox(),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dateController.selectMorningDelivery(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Afternoon",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                items: dateController.afterNoonSlotDelivery
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dateController
                                            .selecteafterNoonSlotTimeDelivery
                                            .isEmpty
                                        ? 'Select Time '
                                        : dateController
                                            .selecteafterNoonSlotTimeDelivery
                                            .value,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                underline: const SizedBox(),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dateController
                                        .selectAfterNoonDelivery(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  ],
                ),


                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color?>(Colors.blue),
                        ),
                        onPressed: () {
                          if (dateController.selectedDateString ==
                              dateController.selectedDateStringDelivery) {
                            Get.snackbar('Error !!',
                                'Delivery date and collection date same',
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            Get.offAll(const UserScreen());
                          }

                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )))
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isTimeSelected = false;
}
