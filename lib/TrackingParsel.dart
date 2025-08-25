import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:pak_info/webViewPage.dart';
import 'package:provider/provider.dart';

class CheckTrackingparsel extends StatefulWidget {
  const CheckTrackingparsel({super.key});

  @override
  State<CheckTrackingparsel> createState() => _CheckTrackingparselState();
}

class _CheckTrackingparselState extends State<CheckTrackingparsel> {
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
          "Tracking Package",
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _makeContainer(
                'https://ep.gov.pk/track.asp',
                'Pakistan Post',
                'Asset/Images/idPbaNmYYh_logos.jpeg',
                Colors.redAccent,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://www.tcsexpress.com/tracking',
                'TCS',
                'Asset/Images/TCS.jpg',
                Colors.red,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://www.leopardscourier.com/leopards-tracking',
                'Leopards',
                'Asset/Images/Leopares.jpg',
                Colors.orange,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://www.daraz.pk/track-orders-online/',
                'Daraz.pk',
                'Asset/Images/Daraz.png',
                Colors.deepOrange,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://www.17track.net/en',
                'International',
                'Asset/Images/17Tracking.jpg',
                Colors.blue,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://www.mulphilog.com/tracking/1',
                'M and P',
                'Asset/Images/M and P.png',
                Colors.black,
                themeManager,
              ),
              const SizedBox(height: 20),
            ],
          ),
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
