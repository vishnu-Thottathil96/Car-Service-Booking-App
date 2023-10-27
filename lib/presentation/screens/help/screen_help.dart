import 'package:flutter/material.dart';
import 'package:motox/utils/constants/space.dart';
import 'package:motox/utils/constants/text_styles.dart';
import 'package:motox/utils/design_assets/design_assets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              vertical20,
              Text(
                'Enquiry',
                style: TextStyles.mainHeadingBlack,
              ),
              vertical20,
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/icons/support.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 5,
                      child: ListTile(
                        leading: SizedBox(
                          height: 40,
                          width: 50,
                          child: Image.asset(helpPageIcons[index]),
                        ),
                        title: Text(helpHeadings[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => vertical30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
