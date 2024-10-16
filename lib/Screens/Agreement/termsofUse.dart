import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({super.key});

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                    child: Text('TERMS OF USE AGREEMENT',
                        style: TextStyle(
                           color: Color.fromARGB(255, 0, 59, 108),
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.justify,
                    'This Terms of Use Agreement ("Agreement") governs the use of the "Insulin" device manufactured by Agva Healthcare ("Agva Healthcare" or "Company"). By using the "Insulin" device, you ("User" or "You") agree to be bound by the terms and conditions set forth in this Agreement.',
                    style: TextStyle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.justify,
                    '1. Device Use: The "Insulin" device is intended solely for the administration of insulin as prescribed by a licensed healthcare provider. User agrees to use the device in accordance with the instructions provided by Agva Healthcare and the User Manual accompanying the device.',
                    style: TextStyle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.justify,
                    '2. User Responsibility: User acknowledges and agrees that they are solely responsible for the proper use and maintenance of the "Insulin" device. User agrees to follow all safety precautions and guidelines provided by Agva Healthcare and to promptly report any issues or concerns regarding device functionality or performance.',
                    style: TextStyle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.justify,
                    '3. Healthcare Provider Oversight: User acknowledges the importance of ongoing oversight and guidance from a licensed healthcare provider in the management of their diabetes and the use of the "Insulin" device. User agrees to consult with their healthcare provider regarding any changes to their insulin therapy regimen or concerns about device usage.',
                    style: TextStyle(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.justify,
                    'By using the "Insulin" device, User acknowledges that they have read, understood, and agreed to be bound by the terms and conditions of this Agreement. If User does not agree to these terms, they should refrain from using the "Insulin" device.',
                    style: TextStyle(),
                  ),
                ),
                //  Container(
                //       height: 50,
                //       width: MediaQuery.of(context).size.width ,
                //       color: Colors.deepPurple[700],
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [

                //           Icon(Icons.arrow_back),
                //           Icon(Icons.arrow_forward)
                //         ],
                //       ),
                //      )
              ],
            ),
          ),
        ),
        
     
      ),
    );
  }
}
