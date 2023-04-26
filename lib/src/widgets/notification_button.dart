import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin_app/provider/product_provider.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  ProductProvider? productProvider;
  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Alert",
            ),
            actions: [
              TextButton(
                child: const Text("Clear Notification"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    productProvider!.notificationList.clear();
                  });
                },
              ),
              TextButton(
                child: const Text("Okey"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(productProvider!.notificationList.isNotEmpty
                      ? "Your Product On Way"
                      : "No Notification At Yet"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 8, end: 25),
      badgeContent: Text(
        productProvider!.getNotificationIndex.toString(),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.red,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.notifications_none,
          color: Colors.black,
        ),
        onPressed: () {
          myDialogBox(context);
        },
      ),
    );
  }
}
