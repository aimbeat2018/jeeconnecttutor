import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalFunctions {/*
  static InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        color: kPrimaryColor,
      ),
      hintStyle: const TextStyle(color: kPrimaryColor, fontSize: 14),
      hintText: hintext,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  static InputDecoration getInputDecorationPurple(String hintext, IconData iconData) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        color: Colors.white,
      ),
      hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
      hintText: hintext,
      fillColor: kPrimaryColor1,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }
*/
  static InputDecoration getInputDecorationWhite(String hintext) {
    return InputDecoration(
      /*enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),*/
      filled: true,

      // hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
      hintText: hintext,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }
/*
  static InputDecoration getInputDecorationColor(String hintext) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: kPrimaryColor1, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: kPrimaryColor1, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor1),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      // prefixIcon: Icon(
      //   iconData,
      //   color: Colors.white,
      // ),
      hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
      hintText: hintext,
      fillColor: kPrimaryColor1,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message, style: const TextStyle(color: Colors.red)),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade200,
        textColor: kToastTextColor,
        fontSize: 16.0);
  }

  static void showWarningToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade300,
        textColor: kToastTextColor,
        fontSize: 16.0);
  }

  static ConnectivityResult _connectionStatus = ConnectivityResult.none;
  static Connectivity _connectivity = Connectivity();

  static Future<ConnectivityResult> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      _connectionStatus = result;
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return _connectionStatus;
  }

  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd MMM yyyy hh:mm a');
    return formatter.format(date);
  }*/
}