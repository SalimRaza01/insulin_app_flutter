import 'package:flutter/material.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Privacy Policy for Insulin Device and App',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Welcome to AgvaHealthcare’s Insulink Device and App. We are committed to protecting your privacy and ensuring that your personal information is handled in a safe and responsible manner. This Privacy Policy explains how we collect, use, share, and protect your information when you use the Insulink device and its associated mobile application.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '2. Data Collection and Usage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'The policy would outline what data is collected from users, such as glucose readings, insulin doses, and other health-related information.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'It should specify that this data is used primarily to provide insulin delivery services, monitor health metrics, and improve device performance.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '3. Data Sharing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Details on whether and how data is shared with third parties, such as healthcare providers, for treatment purposes.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Clarification on any sharing with Agva Healthcare affiliates or partners for research or marketing purposes.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '4. Security Measures',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Information on security protocols used to protect user data from unauthorized access, including encryption methods and access controls.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '5. User Controls',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Explanation of how users can access, modify, or delete their data.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Options available to limit or opt-out of certain data sharing practices, if applicable.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '6. Consent and Updates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'How user consent is obtained for data collection and sharing.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Notification of any updates to the privacy policy and how users will be informed.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '7. Compliance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Assurance of compliance with relevant privacy laws and regulations, such as GDPR or HIPAA, depending on the jurisdiction and use case.',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 16.0),
              // Add other sections similarly
              Text(
                '8. Contact Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'AgVa Healthcare',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Address : A-1, A Block, Sector 83, Noida, U.P. 201301',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              Text(
                'Support : info@agvahealthcare.com',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              Text(
                'Contact : +91-73 30 40 50 60',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
