import 'package:flutter/material.dart';
import 'package:pak_info/webViewPage.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/fescobill', "FESCO",
                  'Asset/Images/Fesco2.jpg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer(
                  'https://www.lesco.gov.pk:36269/Modules/CustomerBillN/CheckBill.asp',
                  "LESCO",
                  'Asset/Images/Lesco.jpg',
                  Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/iescobill', "IESCO",
                  'Asset/Images/Iesco.jpg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer(
                  'https://www.ke.com.pk/customer-services/know-your-bill/',
                  "K Electric",
                  'Asset/Images/K electric 2.png',
                  Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/mepcobill', "MEPCO",
                  'Asset/Images/Mepco.jpg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/gepcobill', "GEPCO",
                  'Asset/Images/gepco.jpeg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/pescobill', "PESCO",
                  'Asset/Images/Pesco.jpg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/sepcobill', "SEPCO",
                  'Asset/Images/Sepco.jpg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/qescobill/', "QESCO",
                  'Asset/Images/Qesco.jpg', Colors.black),
              const SizedBox(height: 20),
              _makeContainer('https://bill.pitc.com.pk/hescobill', "HESCO",
                  'Asset/Images/Hesco.jpg', Colors.black),
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
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: borderColor,
                    fontWeight: FontWeight.bold),
              ),
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
