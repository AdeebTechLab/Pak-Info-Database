
import 'package:flutter/material.dart';
import 'package:pak_info/webViewPage.dart';

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
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Tracking Package",style: TextStyle(fontSize: 20,color: Colors.white),),
        leading:IconButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,size: 25,color: Colors.white,),
        ),
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration:BoxDecoration(
         color: Colors.white
        ) ,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              _makeContainer('https://ep.gov.pk/track.asp', 'Pakistan Post','Asset/Images/idPbaNmYYh_logos.jpeg',Colors.redAccent),
              SizedBox(height: 20,),
              _makeContainer('https://www.tcsexpress.com/tracking', 'TCS','Asset/Images/TCS.jpg',Colors.red),
              SizedBox(height: 20,),
              _makeContainer('https://www.leopardscourier.com/leopards-tracking', 'Leopards','Asset/Images/Leopares.jpg',Colors.orange),
              SizedBox(height: 20,),
              _makeContainer('https://www.daraz.pk/track-orders-online/', 'Daraz.pk','Asset/Images/Daraz.png',Colors.deepOrange),
              SizedBox(height: 20,),
              _makeContainer('https://www.17track.net/en', 'International','Asset/Images/17Tracking.jpg',Colors.blue),
              SizedBox(height: 20,),
              _makeContainer('https://www.mulphilog.com/tracking/1', 'M and P','Asset/Images/M and P.png',Colors.black),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  Widget _makeContainer(String Launch_Link,String Title,String ImagePath,Color BorderColor)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12),
      child: GestureDetector(
        onTap: ()
        {
          launchLink(Launch_Link);
        },
        child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                border: Border(
                  top: BorderSide(color: BorderColor, width: 2),
                  right: BorderSide(color: BorderColor, width: 2),
                  bottom: BorderSide(color: BorderColor, width: 2),
                  left: BorderSide(color: BorderColor, ),
                )
            ),
            child:Row(
              children: [
                Container(
                  height: 90,
                  width: 13,
                  decoration: BoxDecoration(
                      color: BorderColor,
                      borderRadius: BorderRadius.circular(11)
                  ),

                ),
                SizedBox(width: 20,),
                Text(Title,style: TextStyle(fontSize: 20,color: BorderColor,fontWeight: FontWeight.bold),),
                Spacer(),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    image: DecorationImage(
                        image: AssetImage(ImagePath),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(width: 5,)
              ],
            )
        ),
      ),
    );
  }
}
