import 'package:get/get.dart';
import 'package:jeeconnecttutor/controllers/courseController.dart';
import 'package:jeeconnecttutor/controllers/paymentController.dart';
import 'package:jeeconnecttutor/controllers/requestController.dart';
import 'package:jeeconnecttutor/repository/courseRepo.dart';
import 'package:jeeconnecttutor/repository/paymentRepo.dart';
import 'package:jeeconnecttutor/repository/requestRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../controllers/authController.dart';
import '../repository/authRepo.dart';
import 'app_constants.dart';

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(
      () => CourseRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => RequestRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
 Get.lazyPut(
      () => PaymentRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() =>
  //     AttendanceRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(
  //     () => SalonRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  // Get.lazyPut(() =>
  //     DistributorRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(
  //     () => CampaignRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(
  //     () => TargetRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //
  // // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CourseController(courseRepo: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => RequestController(requestRepo: Get.find()));
  // Get.lazyPut(() => AttendanceController(attendanceRepo: Get.find()));
  // Get.lazyPut(() => SalonController(salonRepo: Get.find()));
  // Get.lazyPut(() => CartController(cartRepo: Get.find()));
  // Get.lazyPut(() => DistributorController(distributorRepo: Get.find()));
  // Get.lazyPut(() => CampaignController(campaignRepo: Get.find()));
  // Get.lazyPut(() => TargetController(targetRepo: Get.find()));
}
