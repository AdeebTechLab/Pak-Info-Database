import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:pak_info/webViewPage.dart';
import 'package:provider/provider.dart';

class CheckVehicleverification extends StatefulWidget {
  const CheckVehicleverification({super.key});

  @override
  State<CheckVehicleverification> createState() => _CheckVehicleverificationState();
}

class _CheckVehicleverificationState extends State<CheckVehicleverification> {
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
          "Vehicle Verification",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
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
                'https://verifyvehicle.pk/mtmis-islamabad-online-vehicle-verification/',
                'Islamabad',
                'Asset/Images/faisal-mosque.png',
                Colors.brown,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://mtmis.excise.punjab.gov.pk/',
                'Punjab',
                'Asset/Images/MinarePakistan.jpg',
                Colors.orange,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://www.excise.gos.pk/vehicle/vehicle_search',
                'Sindh',
                'Asset/Images/mazar-e-quaid.png',
                Colors.blue,
                themeManager,
              ),
              const SizedBox(height: 20),
              _makeContainer(
                'https://kp.gov.pk/page/online_vehicle_verification/page_type/citizen',
                'KPK',
                'Asset/Images/kpk.png',
                Colors.black54,
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
