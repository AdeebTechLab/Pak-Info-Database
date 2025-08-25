
import 'package:flutter/material.dart';
import 'package:pak_info/webViewPage.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Vehicle Verification",style: TextStyle(fontSize: 20,color: Colors.white),),
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
              _makeContainer('https://verifyvehicle.pk/mtmis-islamabad-online-vehicle-verification/', 'Islamabad','Asset/Images/faisal-mosque.png',Colors.brown),
              SizedBox(height: 20,),
              _makeContainer('https://mtmis.excise.punjab.gov.pk/', 'Punjab','Asset/Images/MinarePakistan.jpg',Colors.orange),
              SizedBox(height: 20,),
              _makeContainer('https://www.excise.gos.pk/vehicle/vehicle_search', 'Sindh','Asset/Images/mazar-e-quaid.png',Colors.blue),
              SizedBox(height: 20,),
              _makeContainer( 'https://kp.gov.pk/page/online_vehicle_verification/page_type/citizen', 'KPK','Asset/Images/kpk.png',Colors.black54),
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
