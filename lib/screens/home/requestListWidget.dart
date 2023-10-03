import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/route_helper.dart';
import '../../model/tutorRequestModel.dart';

class RequestListWidget extends StatefulWidget {
  final TutorRequestModel model;

  const RequestListWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<RequestListWidget> createState() => _RequestListWidgetState();
}

class _RequestListWidgetState extends State<RequestListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                    const TextSpan(
                      text: 'Student name : ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: widget.model.studentName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ])),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                const TextSpan(
                  text: 'Student Address : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: widget.model.studentAddress,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                const TextSpan(
                  text: 'Subject : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: widget.model.courseName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                const TextSpan(
                  text: 'Date & Time : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${widget.model.date} ${widget.model.time}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                const TextSpan(
                  text: 'Day & Shift : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${widget.model.day} ${widget.model.shift}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: const TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Status :  ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Completed',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                elevation: 0,
                color: kYellowColor,
                onPressed: () {
                  Get.toNamed(RouteHelper.getSessionDetailsScreenRoute(
                      widget.model.id!));
                },
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  // side: const BorderSide(color: kRedColor),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
