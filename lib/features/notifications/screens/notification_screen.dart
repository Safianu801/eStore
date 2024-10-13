import 'package:e_store/features/notifications/components/notification_card_style.dart';
import 'package:e_store/features/notifications/model/notification_model.dart';
import 'package:e_store/features/notifications/services/notification_services.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _futureNotifications;
  final NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    _futureNotifications = notificationServices.getAllNotifications(context);
  }

  Future<void> _refreshProducts(BuildContext context) async {
    setState(() {
      _futureNotifications = notificationServices.getAllNotifications(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.grey[200],
        centerTitle: true,
        title: const Text("Notifications", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
        automaticallyImplyLeading: false,
        leadingWidth: 90,
        leading: CustomBackButton(buildContext: context),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _futureNotifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty, color: Colors.grey,),
                Text(
                  "No Notifications Yet!!",
                ),
                Text(
                  "You currently have not performed any shopping activities with this account, all your shopping notification will be displayed here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11
                  ),
                )
              ],
            ));
          } else {
            Map<String, List<NotificationModel>> groupedNotifications = {};
            for (var history in snapshot.data!) {
              String date = DateFormat('MMM d, yyyy').format(history.createdAt);
              if (!groupedNotifications.containsKey(date)) {
                groupedNotifications[date] = [];
              }
              groupedNotifications[date]!.add(history);
            }

            List<String> sortedDates = groupedNotifications.keys.toList()
              ..sort((a, b) => DateFormat('MMM d, yyyy').parse(b).compareTo(
                  DateFormat('MMM d, yyyy').parse(a)));

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var date in sortedDates) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    for (var notificationValue in groupedNotifications[date]!)
                      NotificationCardStyle(notificationModel: notificationValue),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
