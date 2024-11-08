import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newproject/utils/Colors.dart';
class TodaysStatus extends StatelessWidget {
  const TodaysStatus({Key? key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      // height: height * 0.28,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:Theme.of(context).colorScheme.primary
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURRENT READING',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    fontSize: height * 0.015,
                    fontWeight: AppColor.weight600,
                  ),
                ),
                Text(
                  'updated at 1:57 PM  10-JUNE-2024',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    fontSize: height * 0.01,
                    fontWeight: AppColor.weight600,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircularIndicator(
                    context: context,
                  value: 0.5,
                  size: height * 0.10,
                  progressColor: Color.fromARGB(255, 76, 76, 76),
                  valueText: '120',
                 
                  unitText: 'mg/dl',
                ),
                _buildCircularIndicator(
                  context: context,
                  value: 0.5,
                    size: height * 0.10,
                  progressColor: Color.fromARGB(255, 59, 177, 86),
                  valueText: '2.5',
                  unitText: 'units/hr',
                ),
                _buildCircularIndicator(
                    context: context,
                  value: 0.5,
                     size: height * 0.10,
                  progressColor: Color.fromARGB(255, 214, 86, 244),
                  valueText: '2800',
                  unitText: 'units',
                ),
              ],
            ),
                  SizedBox(height: height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLabel('GLUCOMETER' , height, context),
                _buildLabel('INSULIN DOSE', height, context),
                _buildLabel('INSULIN LEVEL', height, context),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _buildCircularIndicator({
    required double value,
    required double size,
    required Color progressColor,
    required String valueText,
    required String unitText,
    required BuildContext context,
    
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: size * 0.1,
                color: progressColor,
                backgroundColor: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  Text(
                    valueText,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: size * 0.25), // Adjust font size as needed
                  ),
                  Text(
                    unitText,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: size * 0.1), // Adjust font size as needed
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
  Widget _buildLabel(String text, double height , BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primaryContainer,
        fontSize: height * 0.013,
        fontWeight: AppColor.lightWeight,
      ),
    );
  }
}