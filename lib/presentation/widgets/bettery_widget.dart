import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({super.key});

  @override
  Widget build(BuildContext context) {
         final height = MediaQuery.of(context).size.height;
     final width = MediaQuery.of(context).size.width;
    return Container(
   height: height * 0.27,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(
        //   color: Colors.grey,
        //   width: 0.2,
        // ),
        color: Theme.of(context).colorScheme.primary,
        // boxShadow: const [
        //   BoxShadow(
        //     offset: Offset(5, 15),
        //     color: Color.fromARGB(255, 199, 199, 199),
        //     blurRadius: 20,
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BATTERY',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryContainer,
                                              fontSize: height * 0.02,
                          fontWeight:AppColor.weight600
                        ),
                      ),
                      Text(
                        'updated 2 hours ago',
                        style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                           fontSize: height * 0.013,
                          fontWeight:AppColor.weight600
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //     decoration: BoxDecoration(color: Colors.green[800]),
                //     child: Padding(
                //       padding: const EdgeInsets.all(5),
                //       child: Text(
                //         'Sufficient',
                //         style: TextStyle(
                //            fontSize: height * 0.015, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                //       ),
                //     ))
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
            
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                       height: height * 0.15,
                        width: width * 0.10,
                        child: Image.asset(
                          "assets/images/BetteryIcon.png",
                        ),
                      ),
                    ],
                  ),
                ),
              
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '50%',
                      style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                        fontSize: height * 0.04,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'SUFFICIENT FOR',
                      style: TextStyle(
                        color: Color.fromARGB(255, 133, 133, 136),
                        fontSize: height * 0.019,
                      ),
                    ),
                    Text(
                      '8 DAYS',
                      style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                        fontSize: height * 0.019,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        Icon(Icons.info,color: Colors.grey,),
                        SizedBox(width: width * 0.015),
                        Text(
                          'Approx. calculation as per usage ',
                          style: TextStyle(
                                   color: Theme.of(context).colorScheme.secondaryContainer,
                            fontSize: height * 0.014,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
