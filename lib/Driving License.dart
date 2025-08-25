import 'package:flutter/material.dart';
import 'package:pak_info/webViewPage.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Driving License",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _makeContainer('https://islamabadpolice.gov.pk/', 'Islamabad',
                  'Asset/Images/faisal-mosque.png', Colors.brown),
              const SizedBox(height: 20),
              _makeContainer('https://dlims.punjab.gov.pk/verify/', 'Punjab',
                  'Asset/Images/MinarePakistan.jpg', Colors.orange),
              const SizedBox(height: 20),
              _makeContainer('https://dls.gos.pk/online-verification.html',
                  'Sindh', 'Asset/Images/mazar-e-quaid.png', Colors.blue),
              const SizedBox(height: 20),
              _makeContainer('https://nha.gov.pk/', 'NHA',
                  'Asset/Images/idfZWiEtvh_logos.png', Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://ptpkp.gov.pk/license-authentication/',
                  'KPK', 'Asset/Images/kpk.png', Colors.black54),
              const SizedBox(height: 20),
              _makeContainer('https://qtp.gob.pk/driving', 'Quetta',
                  'Asset/Images/Quetta.png', Colors.green),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeContainer(
      String launchLinkStr, String title, String imagePath, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => launchLink(launchLinkStr),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
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
              Text(title,
                  style: TextStyle(
                      fontSize: 20,
                      color: borderColor,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
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
