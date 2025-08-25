import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Import all pages
import 'package:pak_info/SimData.dart';
import 'package:pak_info/DrivingLicense.dart';
import 'package:pak_info/OnlineFire.dart';
import 'package:pak_info/FBR.dart';
import 'package:pak_info/VehicleVerification.dart';
import 'package:pak_info/Passport.dart';
import 'package:pak_info/ElectricityBill.dart';
import 'package:pak_info/SuigasBill.dart';
import 'package:pak_info/InternetBill.dart';
import 'package:pak_info/TrackingParsel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  /// Launch URL Function
  Future<void> launchLink(String link) async {
    final linkUri = Uri.parse(link);
    if (!await launchUrl(linkUri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "Pak Info Database V 1.0.0",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          PopupMenuTheme(
            data: PopupMenuThemeData(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 28,
              ),
              onSelected: (String value) {
                if (value == 'About') {
                  launchLink('https://salmanadeeb.wixsite.com/pak-info-database');
                } else if (value == 'ContactWhatsApp') {
                  launchLink('https://wa.me/+923092333121');
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'About',
                  child: ListTile(
                    leading: Icon(Icons.info, color: Colors.black, size: 25),
                    title: Text(
                      "App Update",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'ContactWhatsApp',
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.whatsapp,
                        color: Colors.green, size: 22),
                    title: Text(
                      "Contact WhatsApp",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// BODY START
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _makeContainer("assets/images/sim.jpg", "Sim Owner info", const SimData(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/driving_license.png", "Driving License info", const DrivingLicense(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/online_fir.jpg", "Online FIR info", const OnlineFIR(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/ntn.jpg", "NTN Inquiry info", const FbrPage(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/vehicle.png", "Vehicle Verification info", const VehicleVerification(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/passport.jpg", "Passport Inquiry info", const PassportPage(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/electric_bill.jpg", "Electricity Bill info", const ElectricityBill(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/suigas.jpg", "Sui Gas Bill info", const SuigasBill(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/ptcl.jpg", "Internet Bill info", const InternetBill(), Colors.black),
              const SizedBox(height: 20),

              _makeContainer("assets/images/package_tracking.jpg", "Parcel Tracking info", const TrackingParcel(), Colors.black),

            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Card Widget
  Widget _makeContainer(
      String imagePath, String imageTitle, Widget targetPage, Color borderColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: Card(
          elevation: 8,
          shadowColor: borderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.blue.shade800,
                child: Text(
                  imageTitle,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
