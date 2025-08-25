import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:pak_info/webViewPage.dart';
import 'package:provider/provider.dart';

class DrivingLicense extends StatefulWidget {
  const DrivingLicense({super.key});

  @override
  State<DrivingLicense> createState() => _DrivingLicenseState();
}

class _DrivingLicenseState extends State<DrivingLicense> {
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
        title: const Text("Driving License",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
        ),
      ),
      body: Container(
        color: themeManager.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _makeContainer('https://islamabadpolice.gov.pk/', 'Islamabad',
                  'Asset/Images/faisal-mosque.png', Colors.brown, themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://dlims.punjab.gov.pk/verify/', 'Punjab',
                  'Asset/Images/MinarePakistan.jpg', Colors.orange, themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://dls.gos.pk/online-verification.html',
                  'Sindh', 'Asset/Images/mazar-e-quaid.png', Colors.blue, themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://nha.gov.pk/', 'NHA',
                  'Asset/Images/idfZWiEtvh_logos.png', Colors.black, themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://ptpkp.gov.pk/license-authentication/',
                  'KPK', 'Asset/Images/kpk.png', Colors.black54, themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://qtp.gob.pk/driving', 'Quetta',
                  'Asset/Images/Quetta.png', Colors.green, themeManager),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeContainer(String launchLinkStr, String title, String imagePath,
      Color borderColor, ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => launchLink(launchLinkStr),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: themeManager.cardColor,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: borderColor, width: 2),
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
                child: Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        color: borderColor,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover),
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