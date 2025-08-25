import 'package:flutter/material.dart';
import 'package:pak_info/themeManager.dart';
import 'package:pak_info/webViewPage.dart';
import 'package:provider/provider.dart';

class ElectricityBill extends StatefulWidget {
  const ElectricityBill({super.key});

  @override
  State<ElectricityBill> createState() => _ElectricityBillState();
}

class _ElectricityBillState extends State<ElectricityBill> {
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
          "Electricity Bill",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
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
              _makeContainer('https://bill.pitc.com.pk/fescobill', "FESCO",
                  'Asset/Images/Fesco2.jpg', themeManager),
              const SizedBox(height: 20),
              _makeContainer(
                  'https://www.lesco.gov.pk:36269/Modules/CustomerBillN/CheckBill.asp',
                  "LESCO",
                  'Asset/Images/Lesco.jpg',
                  themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/iescobill', "IESCO",
                  'Asset/Images/Iesco.jpg', themeManager),
              const SizedBox(height: 20),
              _makeContainer(
                  'https://www.ke.com.pk/customer-services/know-your-bill/',
                  "K Electric",
                  'Asset/Images/K electric 2.png',
                  themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/mepcobill', "MEPCO",
                  'Asset/Images/Mepco.jpg', themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/gepcobill', "GEPCO",
                  'Asset/Images/gepco.jpeg', themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/pescobill', "PESCO",
                  'Asset/Images/Pesco.jpg', themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/sepcobill', "SEPCO",
                  'Asset/Images/Sepco.jpg', themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/qescobill/', "QESCO",
                  'Asset/Images/Qesco.jpg', themeManager),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/hescobill', "HESCO",
                  'Asset/Images/Hesco.jpg', themeManager),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeContainer(
      String launchLinkStr, String title, String imagePath, ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => launchLink(launchLinkStr),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: themeManager.cardColor,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: themeManager.textColor, width: 2),
          ),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 13,
                decoration: BoxDecoration(
                  color: themeManager.textColor,
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: themeManager.textColor,
                      fontWeight: FontWeight.bold),
                ),
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