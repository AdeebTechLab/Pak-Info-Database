import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pak_info/OnlineFir.dart';
import 'package:pak_info/Ptcl.dart';
import 'package:pak_info/themeManager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Import all pages
import 'package:pak_info/FBR.dart';
import 'package:pak_info/VehicleVerification.dart';
import 'package:pak_info/Passport.dart';
import 'package:pak_info/TrackingParsel.dart';

import 'Driving License.dart';
import 'Electricity.dart';
import 'SUIGAS.dart';
import 'SimDataPage.dart';

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
    final themeManager = Provider.of<ThemeManager>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine if we should use grid layout (for tablets/wider screens)
    final bool useGridLayout = screenWidth > 600;
    final int crossAxisCount = screenWidth > 900 ? 4 : 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pak Info Database V 0.3.0",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: 28,
            ),
            onPressed: () => themeManager.toggleTheme(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.menu,
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
              PopupMenuItem<String>(
                value: 'About',
                child: ListTile(
                  leading: Icon(Icons.info, color: themeManager.textColor, size: 25),
                  title: Text(
                    "App Update",
                    style: TextStyle(
                        fontSize: 18,
                        color: themeManager.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'ContactWhatsApp',
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.whatsapp,
                      color: Colors.green, size: 22),
                  title: Text(
                    "Contact WhatsApp",
                    style: TextStyle(
                        fontSize: 18,
                        color: themeManager.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      /// BODY START
      body: useGridLayout ? _buildGridView(themeManager, crossAxisCount) : _buildListView(themeManager),
    );
  }

  /// Build Grid View for wider screens
  Widget _buildGridView(ThemeManager themeManager, int crossAxisCount) {
    final items = _getMenuItems();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _makeGridContainer(
            item['imagePath']!,
            item['title']!,
            item['page']! as Widget,
            themeManager,
          );
        },
      ),
    );
  }

  /// Build List View for mobile screens
  Widget _buildListView(ThemeManager themeManager) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _makeContainer("Asset/button/sim.jpg", "Sim Owner info", const SimDataPage(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/Driving Licese.jpg", "Driving License info", const DrivingLicense(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/online fir.jpg", "Online FIR info", const OnlineFire(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/ntn.jpg", "NTN Inquiry info", const CheckFBR(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/Vehicle.jpg", "Vehicle Verification info", const CheckVehicleverification(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/Passport 2.jpg", "Passport Inquiry info", const CheckPassport(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/ElectricBill.jpg", "Electricity Bill info", const ElectricityBill(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/Suigas.jpg", "Sui Gas Bill info", const SuigasBill(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/ptcl.jpg", "Internet Bill info", const PtclBill(), themeManager),
            const SizedBox(height: 20),

            _makeContainer("Asset/button/package tracking.jpg", "Parcel Tracking info", const CheckTrackingparsel(), themeManager),
          ],
        ),
      ),
    );
  }

  /// Get menu items list
  List<Map<String, dynamic>> _getMenuItems() {
    return [
      {
        'imagePath': "Asset/button/sim.jpg",
        'title': "Sim Owner info",
        'page': const SimDataPage(),
      },
      {
        'imagePath': "Asset/button/Driving Licese.jpg",
        'title': "Driving License info",
        'page': const DrivingLicense(),
      },
      {
        'imagePath': "Asset/button/online fir.jpg",
        'title': "Online FIR info",
        'page': const OnlineFire(),
      },
      {
        'imagePath': "Asset/button/ntn.jpg",
        'title': "NTN Inquiry info",
        'page': const CheckFBR(),
      },
      {
        'imagePath': "Asset/button/Vehicle.jpg",
        'title': "Vehicle Verification info",
        'page': const CheckVehicleverification(),
      },
      {
        'imagePath': "Asset/button/Passport 2.jpg",
        'title': "Passport Inquiry info",
        'page': const CheckPassport(),
      },
      {
        'imagePath': "Asset/button/ElectricBill.jpg",
        'title': "Electricity Bill info",
        'page': const ElectricityBill(),
      },
      {
        'imagePath': "Asset/button/Suigas.jpg",
        'title': "Sui Gas Bill info",
        'page': const SuigasBill(),
      },
      {
        'imagePath': "Asset/button/ptcl.jpg",
        'title': "Internet Bill info",
        'page': const PtclBill(),
      },
      {
        'imagePath': "Asset/button/package tracking.jpg",
        'title': "Parcel Tracking info",
        'page': const CheckTrackingparsel(),
      },
    ];
  }

  /// Reusable Card Widget for List View
  Widget _makeContainer(String imagePath, String imageTitle, Widget targetPage, ThemeManager themeManager) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: SizedBox(
        height: 261,
        width: double.infinity,
        child: Card(
          elevation: 8,
          shadowColor: Colors.black,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeManager.containerColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
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

  Widget _makeGridContainer(String imagePath, String imageTitle, Widget targetPage, ThemeManager themeManager) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: SizedBox(
        height: 180,
        width: 160, // You can tweak this width as needed
        child: Card(
          elevation: 6,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 140,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeManager.containerColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: Center(
                  child: Text(
                    imageTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }







}