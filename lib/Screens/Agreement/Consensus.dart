import 'package:flutter/material.dart';
import 'package:newproject/utils/Colors.dart';

class ConsensusAgreement extends StatefulWidget {
  const ConsensusAgreement({super.key});

  @override
  State<ConsensusAgreement> createState() => _ConsensusAgreementState();
}

class _ConsensusAgreementState extends State<ConsensusAgreement> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(18.0),
           child: Column(
           
                 crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('Consensus Agreement ',style: TextStyle(color: AppColor.appbarColor,fontSize: 20,fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  textAlign: TextAlign.justify,
                  'Efficacy and Safety: There is a consensus that the "Insulin" device manufactured by Agva Healthcare should demonstrate high efficacy in delivering insulin accurately and safely. It should have precise dosage delivery capabilities and incorporate safety features to minimize the risk of dosing errors and hypoglycemia.',
                  style: TextStyle(
                  
                  ),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.justify,
                  'User-Centered Design: The device should be designed with the user in mind, ensuring ease of use, intuitive operation, and ergonomic design. Clear instructions and user-friendly interfaces should facilitate seamless integration into the daily lives of patients managing diabetes.',
                  style: TextStyle(
                  
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.justify,
                 'Technological Innovation: Given the advancements in insulin delivery technology, there is an expectation for Agva Healthcare "Insulin" device to incorporate innovative features that enhance convenience, flexibility, and precision in insulin delivery. This may include integration with continuous glucose monitoring systems, smart dosing algorithms, and connectivity options for data sharing with healthcare providers.',
                  style: TextStyle(
                  
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.justify,
                  'Continuous Improvement and Feedback Mechanisms: Agva Healthcare should establish mechanisms for gathering feedback from users and healthcare providers to identify areas for improvement and innovation. This feedback loop should inform ongoing product development efforts to enhance the performance, usability, and satisfaction of the "Insulin" device over time.',
                  style: TextStyle(
                  
                  ),
                ),
              ),
         
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  textAlign: TextAlign.justify,
                  'By using the "Insulin" device, User acknowledges that they have read, understood, and agreed to be bound by the terms and conditions of this Agreement. If User does not agree to these terms, they should refrain from using the "Insulin" device.',
                  style: TextStyle(
                  
                  ),
                ),
              ),
             
            ],
           ),
          
         ),
       ),
    
      ),
    );
  }
}