import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;

  String get today => DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get tomorrow => DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(const Duration(days: 1)));
  String get selectedDateString =>
      DateFormat('yyyy-MM-dd').format(selectedDate.value);

  void selectToday() {
    selectedDate.value = DateTime.now();
  }

  void selectTomorrow() {
    selectedDate.value = DateTime.now().add(const Duration(days: 1));
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  var morningSlot = ["9:00 AM", "10:00 AM", "11:00 AM"].obs;
  var afterNoonSlot = ["1:00 PM", "2:00 PM", "3:00 PM"].obs;

  var selecteMorningSlotTime = ''.obs;
  var selecteafterNoonSlotTime = ''.obs;

  void selectMorning(String? value) {
    selecteMorningSlotTime.value = value!;
    selecteafterNoonSlotTime.value = ''; // Clear afternoon selection
  }

  void selectAfterNoon(String? value) {
    selecteafterNoonSlotTime.value = value!;
    selecteMorningSlotTime.value = ''; // Clear morning selection
  }


  /// selecte date delivery

  var selectedDateDelivery = DateTime.now().obs;

  String get todayDelivery => DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get tomorrowDelivery => DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(const Duration(days: 1)));
  String get selectedDateStringDelivery =>
      DateFormat('yyyy-MM-dd').format(selectedDateDelivery.value);

  void selectTodayDelivery() {
    selectedDateDelivery.value = DateTime.now();
  }

  void selectTomorrowDelivery() {
    selectedDateDelivery.value = DateTime.now().add(const Duration(days: 1));
  }

  void selectDateDelivery(DateTime date) {
    selectedDateDelivery.value = date;
  }

  var morningSlotDelivery = ["9:00 AM", "10:00 AM", "11:00 AM"].obs;
  var afterNoonSlotDelivery = ["1:00 PM", "2:00 PM", "3:00 PM"].obs;

  var selecteMorningSlotTimeDelivery = ''.obs;
  var selecteafterNoonSlotTimeDelivery = ''.obs;

  void selectMorningDelivery(String? value) {
    selecteMorningSlotTimeDelivery.value = value!;
    selecteafterNoonSlotTimeDelivery.value = ''; // Clear afternoon selection
  }

  void selectAfterNoonDelivery(String? value) {
    selecteafterNoonSlotTimeDelivery.value = value!;
    selecteMorningSlotTimeDelivery.value = ''; // Clear morning selection
  }
}
