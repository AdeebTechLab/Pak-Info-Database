import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:pak_info/webViewPage.dart';
import 'package:provider/provider.dart';

class CheckPassport extends StatefulWidget {
  const CheckPassport({super.key});

  @override
  State<CheckPassport> createState() => _CheckPassportState();
}

class _CheckPassportState extends State<CheckPassport> {
  void launchLink(String link) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(url: link)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeManager.primaryColor,
        title: const Text(
          "Passport",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: themeManager.backgroundColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _makeContainer(
              'https://onlinemrp.dgip.gov.pk/contact-us/',
              'Passport Inquiry',
              'Asset/Images/Pakistan Passport.jpg',
              Colors.green,
              themeManager,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _makeContainer(
      String launchLink,
      String title,
      String imagePath,
      Color borderColor,
      ThemeManager themeManager,
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: GestureDetector(
        onTap: () {
          this.launchLink(launchLink);
        },
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: themeManager.cardColor,
            borderRadius: BorderRadius.circular(11),
            border: Border(
              top: BorderSide(color: borderColor, width: 2),
              right: BorderSide(color: borderColor, width: 2),
              bottom: BorderSide(color: borderColor, width: 2),
              left: BorderSide(color: borderColor),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 13,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: borderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
