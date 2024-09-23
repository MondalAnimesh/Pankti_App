import 'package:flutter/material.dart';

Widget placeInfo(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        print("tap");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/download.jpg"))
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15,top: 15,),
                            child: Text("place name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15,bottom: 15),
                            child: Text("in the area",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w200)),
                          )
                        ],
                      ),
                    ),
                  ),
  );
}