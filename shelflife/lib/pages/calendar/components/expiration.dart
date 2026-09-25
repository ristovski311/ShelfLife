import 'package:flutter/material.dart';
import 'package:shelflife/classes/models/expiration.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/calendar/components/expiration_confirmation.dart';
import 'package:shelflife/pages/calendar/controller.dart';

class ExpirationCardWidget extends StatelessWidget {
  final Expiration expiration;
  final CalendarController controller;

  const ExpirationCardWidget({
    super.key,
    required this.expiration,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Color cardBackgroundColor;
    if (expiration.noted) {
      cardBackgroundColor = Colors.green.withValues(alpha: 0.15);
    } else if (expiration.daysUtilExpiration() > 15) {
      cardBackgroundColor = Theme.of(context).colorScheme.surface;
    } else {
      cardBackgroundColor = Theme.of(context).colorScheme.secondary
          .withValues(alpha: 0.15);
    }

    return InkWell(
      onTap: () => {
        showModalBottomSheet(
          context: context,
          isScrollControlled: false,
          builder: (BuildContext context) {
            return ExpirationConfirmationWidget(
              expiration: expiration,
              controller: controller,
            );
          },
        ),
      },
      child: Container(
        padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 16),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            right: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 4),
            Icon(
              expiration.hasExpired() ? Icons.alarm_off : Icons.alarm,
              size: 24,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expiration.productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    expiration.productBrand,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${"Expiration".tr}: ${expiration.prettyPrintExpirationDate()}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: expiration.hasExpired()
                  ? [
                      SizedBox(height: 2),
                      Text(
                        "EXPIRED".tr,
                        style: TextStyle(
                          color: expiration.noted
                              ? Colors.green
                              : Theme.of(context).colorScheme.error,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        expiration.noted ? "NOTED".tr : "UNNOTED".tr,
                        style: TextStyle(
                          color: expiration.noted
                              ? Colors.green
                              : Theme.of(context).colorScheme.error,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]
                  : (expiration.noted
                        ? [
                            SizedBox(height: 2),
                            Text(
                              "NOTED".tr,
                              style: TextStyle(
                                color: expiration.noted
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.error,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]
                        : [
                            Text(
                              "Expires in".tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              expiration.daysUtilExpiration().toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "days".tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]),
            ),
          ],
        ),
      ),
    );
  }
}
