import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:pak_info/webViewPage.dart';
import 'package:provider/provider.dart';

class SimDataPage extends StatefulWidget {
  const SimDataPage({super.key});

  @override
  State<SimDataPage> createState() => _SimDataPageState();
}

class _SimDataPageState extends State<SimDataPage> {
  void launchLink(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeManager.primaryColor,
        title: const Text(
          "Sim Data",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 25, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: themeManager.backgroundColor),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSimCard(
              url: 'https://livetrackeresim.com/',
              title: 'Find Owner Name No:1 Server:1',
              imagePath: 'Asset/Images/Sim2.jpg',
              themeManager: themeManager,
            ),
            const SizedBox(height: 20),
            _buildSimCard(
              url: 'https://cnic.sims.pk/',
              title: 'Register Sim on CNIC Server:2',
              imagePath: 'Asset/Images/Sim1.jpg',
              themeManager: themeManager,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimCard({
    required String url,
    required String title,
    required String imagePath,
    required ThemeManager themeManager,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => launchLink(url),
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: themeManager.cardColor,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: themeManager.primaryColor, width: 2),
          ),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 13,
                decoration: BoxDecoration(
                  color: themeManager.primaryColor,
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: themeManager.textColor,
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