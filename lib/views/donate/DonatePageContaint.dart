import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:umoja/views/donate/ButtonContainer.dart';
import 'package:umoja/views/donate/CheckboxWidget.dart';
import 'TextProvider.dart';

class DonatePageContaint extends StatelessWidget{
  const DonatePageContaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 30
      ),
      child: Column(
      children: [

          Center(
            child: Text(
              "Enter the Amount",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

          SizedBox(height: 5,),

           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextField(
                  controller: TextEditingController(text: textProvider.text),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.green
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '\$0',
                    hintStyle: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Colors.green
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0, 
                      horizontal: 8.0
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  )

                ),

                SizedBox(height: 50,),

                ButtonContainer(),

                SizedBox(height: 30,),

                CheckboxWidget(),

                SizedBox(height: 100,),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Text(
                      'Donate',
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.only(
                        left: 100,
                        right:100
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                          color: Colors.green,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                )

                

              ],
            ),
           ),

        ],
      ),
    );
  }
}