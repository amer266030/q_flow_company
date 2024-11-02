import 'package:flutter/material.dart';
import 'package:q_flow_company/reusable_components/page_header_view.dart';
import 'package:q_flow_company/theme_data/extensions/text_style_ext.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              PageHeaderView(title: 'Privacy Policy'),
              Text(
                "Tuwaiq Academy (Security and Privacy Policy) is presented in order to define its procedures and practices, in order to protect all the rights of its users by maintaining the confidentiality of personal information and private information, and providing them with the highest standards of protection. This policy has been prepared to disclose the Academy's approach to collecting information and ways of using it and publishing it on the site; so please read and review this policy carefully before using the site, as your use of it is your explicit, unconditional and irrevocable consent.",
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Effective Date:",
                style: context.titleSmall,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "1. Introduction",
                style: context.bodyLarge,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "We care about your privacy. This policy explains how we collect, use, and protect your information.",
                style: context.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "2. Information We Collect",
                style: context.bodyLarge,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                " Visitors Rating. \n Total number of interviews. \n Top in demand Majors.",
                style: context.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "3. How We Use Your Info",
                style: context.bodyLarge,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                " Facilitate interview scheduling. \n Provide analytics for event management.",
                style: context.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "4. Data Security",
                style: context.bodyLarge,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "We implement security measures to protect your information.",
                style: context.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "5. Your Rights",
                style: context.bodyLarge,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "You can access, modify, or delete your info. Contact us for requests.",
                style: context.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
