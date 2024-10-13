import 'package:e_store/features/notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCardStyle extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCardStyle({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationModel.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        notificationModel.message,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('MM/dd/yyyy hh:mm')
                            .format(notificationModel.createdAt),
                        style: TextStyle(fontSize: 10, color: Colors.grey[300]),
                      )
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 150,
                    child: Image.network(notificationModel.image),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
