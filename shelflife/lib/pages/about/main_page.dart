import 'package:flutter/material.dart';
import 'package:shelflife/components/illustration.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/about/controller.dart';

class AboutMainPage extends StatefulWidget {
  const AboutMainPage({super.key});

  @override
  State<AboutMainPage> createState() => _AboutMainPageState();
}

class _AboutMainPageState extends State<AboutMainPage> {
  final controller = AboutController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Here to help store workers!".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8),
              SeparatorWidget(),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "This application is created to help store workers take care of products and aritcles, by making sure they take notice of the expiration date of said items!"
                      .tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 16),
              IllustrationWidget(
                imagePath: "assets/illustrations/AboutIllustration1.png".tr,
                height: 180,
              ),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "${"Never miss an expiring item using the applications notification system!".tr}\n\n${"Simply create an expiration notification in 'Calendar' section, and you will recieve a notification on your phone 15 days in advance!".tr}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
