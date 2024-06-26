import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jeeconnecttutor/constant/app_constants.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/model/commonAuthTokenRequestModel.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/model/otpModel.dart';
import 'package:jeeconnecttutor/model/profileViewModel.dart';
import 'package:jeeconnecttutor/model/registerModel.dart';
import 'package:jeeconnecttutor/model/response/gradesModel.dart';
import 'package:jeeconnecttutor/model/response/subjectResponseModel.dart';
import 'package:jeeconnecttutor/model/updateProfileModel.dart';
import 'package:jeeconnecttutor/model/updateProfileResponseModel.dart';

import '../model/loginModel.dart';
import '../model/request/gradeRequestModel.dart';
import '../model/response/bannerModel.dart';
import '../model/response/boardsModel.dart';
import '../model/termsPrivacyHelpDynamicContentResponseModel.dart';
import '../repository/authRepo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  LoginModel? loginModel;

  RegisterModel? registerModel;

  SubjectResponseModel? subjectResponseModel;
  ProfileViewModel? profileViewModel;
  BoardsModel? boardsModel;
  GradesModel? gradesModel;
  BannerModel bannerModel = BannerModel();

  UpdateProfileResponseModel? updateProfileResponseModel;
  CommonResponseModel? commonResponseModel;
  TermsPrivacyHelpDynamicContentResponseModel?
      termsPrivacyHelpDynamicContentResponseModel;


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

    Response response=await authRepo.login(phone: phone,password: password,deviceToken: deviceToken);
    if(response.statusCode==200){
      loginModel=LoginModel.fromJson(response.body);
      if(loginModel!.status=="200"){
      authRepo.saveUserId(loginModel!.userId!);
      authRepo.saveUserMobile(loginModel!.mobileNo!);
      authRepo.saveUserName(loginModel!.firstName!+loginModel!.lastName!);
      authRepo.saveUserUniqueId(loginModel!.uniqueCode!);
      authRepo.saveUserId(loginModel!.userId!.toString());
      authRepo.saveUserToken(deviceToken!);
    }
      }
    _isLoading = false;
    update();
    return loginModel;
  }

  Future<RegisterModel?> registerUser(
      {String? firstName,
      String? lastName,
      String? phone,
      String? email,
      String? address,
      String? password,
      String? pincode,
      String? adhar,
      String? pan,
      String? bankname,
      String? holdername,
      String? accountNo,
      String? ifsc,
      String? referralCode,
      String? board,
      String? grade,
      String? subjects,
      XFile? resume,
      String? modeOfTeachingSelected}) async {
    _isLoading = true;
    update();
    String firebaseToken = "";
    FirebaseMessaging.instance
        .getToken()
        .then((value) async {
      firebaseToken =
          value.toString();
    Response response = await authRepo.register(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        address: address,
        password: password,
        pincode: pincode,
        adhar: adhar,
        pan: pan,
        bankname: bankname,
        holdername: holdername,
        accountNo: accountNo,
        ifsc: ifsc,
        referralCode: referralCode,
        board: board,
        grade: grade,
        subjects: subjects,
        resume: resume,
        token: firebaseToken,
        modeOfTeachingSelected: modeOfTeachingSelected);

    if (response.statusCode == 200) {
      if (response.body['status'] == "200") {
        registerModel = RegisterModel.fromJson(response.body);

        authRepo.saveUserMobile(registerModel!.mobileNo!);

      } else {
        registerModel = RegisterModel(status: "403");
      }
    } else {
      registerModel = RegisterModel(status: "403");
    }
    });
    _isLoading = false;
    update();
    return registerModel;
  }


  Future<UpdateProfileResponseModel?> updateProfile({
    String? firstName,
  String? lastName,
  String? email,
  String? address,
  String? pincode,
  String? adhar,
  String? pan,
  String? bankname,
  String? holdername,
  String? accountNo,
  String? ifsc,
  String? board,
  String? grade,
  String? subjects,
  XFile? resume,
  String? modeOfTeachingSelected,
  String? userId}) async {
    _isLoading = true;
    update();

    Response response = await authRepo.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
        pincode: pincode,
        adhar: adhar,
        pan: pan,
        bankname: bankname,
        holdername: holdername,
        accountNo: accountNo,
        ifsc: ifsc,
        board: board,
        grade: grade,
        subjects: subjects,
        resume: resume,
        modeOfTeachingSelected: modeOfTeachingSelected,
        userId:userId);

    if (response.statusCode == 200) {
      if (response.body['status'] == "200") {
        updateProfileResponseModel =
            UpdateProfileResponseModel.fromJson(response.body);
        // authRepo.saveUserToken(token);
      } else {
        updateProfileResponseModel = UpdateProfileResponseModel(status: '403');
      }
    } else {
      updateProfileResponseModel = UpdateProfileResponseModel(status: '403');
    }
    _isLoading = false;
    update();
    return updateProfileResponseModel;
  }

  Future<OtpModel?> sendRegisterOtp({String? phone}) async {
    _isLoading = true;
    update();

    Response response = await authRepo.sendRegisterOtp(phone: phone);

    if (response.statusCode == 200) {
      if (response.body['status'] == "200") {
        otpModel = OtpModel.fromJson(response.body);
        showCustomSnackBar("Your otp to proceed - ${otpModel!.otp}", isError: false);
      } else {
        otpModel = OtpModel(status: "403");
      }
    } else {
      otpModel = OtpModel(status: "403");
    }
    _isLoading = false;
    update();
    return otpModel;
  }
  Future<OtpModel?> forgotsendOtp({String? mobile}) async{
    _isLoading=true;
    update();
    
    Response response=await authRepo.sendForgotOtp(mobile: mobile);
    if(response.statusCode==200){
      otpModel=OtpModel.fromJson(response.body);
    }
    else{
      otpModel=OtpModel();
    }
    _isLoading=false;
    update();
    return otpModel;
  }



  Future<OtpModel?> changePassword(
      String mobile, String password) async {
    _isLoading = true;

    Response response = await authRepo.updatePassword(mobile, password);

    if (response.statusCode == 200) {
        otpModel =
            OtpModel.fromJson(response.body);
    } else {
      otpModel = OtpModel(status: '403');
    }
    _isLoading = false;
    update();
    return otpModel;
  }

  Future<ProfileViewModel?> getProfile() async {
    _isLoading = true;
    // update();

    String userId = await Get.find<AuthController>().getUserId();

    var url =
        '${AppConstants.baseUrl}${AppConstants.getProfile}';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
        },
        body: {
          'user_id': userId,
        }
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

  Future<BoardsModel?> getBoards() async {
    _isLoading = true;
String? userId=await Get.find<AuthController>().getUserId();
    var url =
        '${AppConstants.baseUrl}${AppConstants.boardlist}?course_id=1';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
        }
      );
      // final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        boardsModel =
            BoardsModel.fromJson(json.decode(response.body));
      } else {
        boardsModel = BoardsModel();
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return boardsModel;
  }

  Future<GradesModel?> getGrades(String boardId) async {
    _isLoading = true;

    var url =
        '${AppConstants.baseUrl}${AppConstants.gradeslist}?board_id=${boardId}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
        },
      );

      if (response.statusCode == 200) {
        gradesModel =
            GradesModel.fromJson(json.decode(response.body));
      } else {
        gradesModel = GradesModel();
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return gradesModel;
  }


  Future<SubjectResponseModel?> subjectListingGradeWise(GradeRequestModel gradeRequestModel) async {
    _isLoading = true;
    update();

    Response response = await authRepo.subjectListingGradeWise(gradeRequestModel);

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      subjectResponseModel = SubjectResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      subjectResponseModel = SubjectResponseModel(status: "403");
    }
    _isLoading = false;
    update();
    return subjectResponseModel;
  }


  Future<BannerModel> getBanners() async {
    var url = '${AppConstants.baseUrl}${AppConstants.banner}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData == 'Unauthorized') {
        throw const HttpException('Auth Failed');
      }

      bannerModel = BannerModel.fromJson(json.decode(response.body));

      return bannerModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<TermsPrivacyHelpDynamicContentResponseModel?> dynamicContent() async {
    var url = '${AppConstants.baseUrl}${AppConstants.dynamic_cantent}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
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
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
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
