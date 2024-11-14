// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          'Terrms & Conditions',
          style: TextStyle(
    
              // fontSize: 24,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return ViewPortrait();
          } else {
            return ViewLandscape();
          }
        }),
      ),
    );
  }
}

class ViewPortrait extends StatelessWidget {
  const ViewPortrait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'User Agreement',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'A Terms and Conditions agreement acts as a legal contract between you AgVa Healthcare and the user. Its where you maintain your rights to exclude users from your app in the event that they abuse your website/app, set out the rules for using your service and note other important details and disclaimers. Having a Terms and Conditions agreement is completely optional. No laws require you to have one. Not even the super-strict and wide-reaching General Data Protection Regulation (GDPR). Your Terms and Conditions agreement will be uniquely yours. While some clauses are standard and commonly seen in pretty much every Terms and Conditions agreement its up to you to set the rules and guidelines that the user must agree to.Terms and Conditions agreements are also known as Terms of Service or Terms of Use agreements. These terms are interchangeable, practically speaking. More rarely, it may be called something like an End User Services Agreement (EUSA).',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color:   Theme.of(context).colorScheme.secondaryContainer,

                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ViewLandscape extends StatelessWidget {
  const ViewLandscape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'User Agreement',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 740,
                    child: Text(
                      'A Terms and Conditions agreement acts as a legal contract between you AgVa Healthcare and the user. Its where you maintain your rights to exclude users from your app in the event that they abuse your website/app, set out the rules for using your service and note other important details and disclaimers. Having a Terms and Conditions agreement is completely optional. No laws require you to have one. Not even the super-strict and wide-reaching General Data Protection Regulation (GDPR). Your Terms and Conditions agreement will be uniquely yours. While some clauses are standard and commonly seen in pretty much every Terms and Conditions agreement its up to you to set the rules and guidelines that the user must agree to.Terms and Conditions agreements are also known as Terms of Service or Terms of Use agreements. These terms are interchangeable, practically speaking. More rarely, it may be called something like an End User Services Agreement (EUSA).',
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
