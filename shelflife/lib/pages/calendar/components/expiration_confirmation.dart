import 'package:flutter/material.dart';
import 'package:shelflife/classes/models/expiration.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/calendar/controller.dart';

class ExpirationConfirmationWidget extends StatelessWidget {
  final Expiration expiration;
  final CalendarController controller;

  const ExpirationConfirmationWidget({
    super.key,
    required this.expiration,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "Manage expiration".tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
          ),
          SizedBox(height: 8),
          SeparatorWidget(),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                if (!expiration.noted) ...[
                  OutlinedButton(
                    onPressed: () => {
                      controller.noteExpirationByIdCalendar(expiration.id),
                      Navigator.pop(context),
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 32,
                        right: 32,
                      ),
                      side: BorderSide(width: 1, color: Colors.green),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_box_rounded, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Confirm".tr,
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),
                ],
                OutlinedButton(
                  onPressed: () => {
                    controller.deleteExpirationCalendar(expiration.id),
                    Navigator.pop(context),
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                      left: 32,
                      right: 32,
                    ),
                    side: BorderSide(width: 1, color: Colors.red),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text("Delete".tr, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  //child: Text("Delete".tr, style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
