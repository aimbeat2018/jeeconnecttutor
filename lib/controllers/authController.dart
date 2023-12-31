import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/constant/app_constants.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/model/commonAuthTokenRequestModel.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/model/otpModel.dart';
import 'package:jeeconnecttutor/model/profileViewModel.dart';
import 'package:jeeconnecttutor/model/registerModel.dart';
import 'package:jeeconnecttutor/model/updateProfileModel.dart';
import 'package:jeeconnecttutor/model/updateProfileResponseModel.dart';

import '../model/loginModel.dart';
import '../model/termsPrivacyHelpDynamicContentResponseModel.dart';
import '../repository/authRepo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  LoginModel? loginModel;

  RegisterModel? registerModel;

  ProfileViewModel? profileViewModel;

  UpdateProfileResponseModel? updateProfileResponseModel;
  CommonResponseModel? commonResponseModel;
  TermsPrivacyHelpDynamicContentResponseModel?
      termsPrivacyHelpDynamicContentResponseModel;

  List bannerList = [];

  OtpModel? otpModel;

  String? msgReset;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  Future<LoginModel?> loginUser(
      {String? phone,
      String? password,
      String? role,
      String? deviceToken}) async {
    _isLoading = true;
    update();

    var url =
        '${AppConstants.baseUrl}${AppConstants.login}?email=${phone!}&password=${password!}&role=${role!}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData['validity'] == 1) {
        loginModel = LoginModel.fromJson(json.decode(response.body));

        authRepo.saveUserMobile(loginModel!.phone!);
        authRepo.saveUserName(loginModel!.name!);
        authRepo.saveUserImage(loginModel!.image!);
        authRepo.savereferral_code(loginModel!.referral_code!);
        authRepo.savereferral_stud(loginModel!.referral_stud!);
        authRepo.saveUserUniqueId(loginModel!.uniqueCode!);

        if (loginModel!.profileUpdated == "3") {
          authRepo.saveUserToken(loginModel!.token!);
          authRepo.saveUserId(loginModel!.userId!.toString());
        }

        // for testing only
        if (loginModel!.profileUpdated == "2") {
          authRepo.saveUserToken(loginModel!.token!);
          authRepo.saveUserId(loginModel!.userId!.toString());
        }
      } else {
        loginModel = LoginModel(validity: 0);
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return loginModel;
  }

  Future<RegisterModel?> registerUser(
      {String? name,
      String? email,
      String? phone,
      String? password,
      String? confirmPassword,
      String? pincode,
      String? roleId,
      String? referralCode}) async {
    _isLoading = true;
    update();

    Response response = await authRepo.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        pincode: pincode,
        role_Id: roleId,
        referral_Code: referralCode ?? "");

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        registerModel = RegisterModel.fromJson(response.body);

        authRepo.saveUserMobile(registerModel!.data!.phone!);
      } else {
        registerModel = RegisterModel(status: 403);
      }
    } else {
      registerModel = RegisterModel(status: 403);
    }
    _isLoading = false;
    update();
    return registerModel;
  }

  Future<OtpModel?> sendRegisterOtp({String? phone}) async {
    _isLoading = true;
    update();

    Response response = await authRepo.sendRegisterOtp(phone: phone);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        otpModel = OtpModel.fromJson(response.body);
        showCustomSnackBar("Your otp to proceed - ${otpModel!.otp}", isError: false);
      } else {
        otpModel = OtpModel(status: 403);
      }
    } else {
      otpModel = OtpModel(status: 403);
    }
    _isLoading = false;
    update();
    return otpModel;
  }

  Future<UpdateProfileResponseModel?> updateProfile(
      UpdateProfileModel model, String userId, String token) async {
    _isLoading = true;
    update();

    Response response = await authRepo.updateProfile(model);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        updateProfileResponseModel =
            UpdateProfileResponseModel.fromJson(response.body);
        authRepo.saveUserToken(token);
        authRepo.saveUserId(userId);
      } else {
        updateProfileResponseModel = UpdateProfileResponseModel(status: 403);
      }
    } else {
      updateProfileResponseModel = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return updateProfileResponseModel;
  }

  Future<UpdateProfileResponseModel?> changePassword(
      String mobile, String password) async {
    _isLoading = true;

    Response response = await authRepo.updatePassword(mobile, password);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        updateProfileResponseModel =
            UpdateProfileResponseModel.fromJson(response.body);
      } else {
        updateProfileResponseModel = UpdateProfileResponseModel(status: 403);
      }
    } else {
      updateProfileResponseModel = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return updateProfileResponseModel;
  }

  Future<ProfileViewModel?> getProfile(String token) async {
    _isLoading = true;
    // update();

    // String token = courseRepo.getUserToken();

    var url =
        '${AppConstants.baseUrl}${AppConstants.getProfile}?auth_token=$token';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      // final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        profileViewModel =
            ProfileViewModel.fromJson(json.decode(response.body));
      } else {
        profileViewModel = ProfileViewModel();
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return profileViewModel;
  }

  Future<List> getBanners() async {
    String? token = authRepo.getUserToken();
    var url = '${AppConstants.baseUrl}${AppConstants.banner}?auth_token=$token';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData == 'Unauthorized') {
        throw const HttpException('Auth Failed');
      }

      bannerList = json.decode(response.body);

      return bannerList;
    } catch (error) {
      rethrow;
    }
  }

  Future<TermsPrivacyHelpDynamicContentResponseModel?> dynamicContent() async {
    var url = '${AppConstants.baseUrl}${AppConstants.dynamic_cantent}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
        termsPrivacyHelpDynamicContentResponseModel =
            TermsPrivacyHelpDynamicContentResponseModel.fromJson(
                json.decode(response.body));
      _isLoading = false;
      return termsPrivacyHelpDynamicContentResponseModel;
    } catch (error) {
      termsPrivacyHelpDynamicContentResponseModel;
      rethrow;
    }
  }

  Future<CommonResponseModel?> logoutUser() async {
    _isLoading = true;
    CommonAuthTokenRequestModel authRequestModel= CommonAuthTokenRequestModel();
    authRequestModel.authToken=authRepo.getUserToken();;

    var url = '${AppConstants.baseUrl}${AppConstants.logout}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: jsonEncode(authRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        commonResponseModel =
            CommonResponseModel.fromJson(json.decode(response.body));
      }

      _isLoading = false;
      return commonResponseModel;
    } catch (error) {
      commonResponseModel;
      rethrow;
    }
  }
  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  String getUserId() {
    return authRepo.getUserId();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String getUserUniqueId() {
    return authRepo.getUserUniqueId();
  }

  String getUserImage() {
    return authRepo.getUserImage();
  }

  String getUserName() {
    return authRepo.getUserName();
  }

  String getUserMobile() {
    return authRepo.getUserMobile();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
