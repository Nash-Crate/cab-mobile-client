import 'package:flutter/material.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_client/presentation/constants/constants.dart';
import 'package:mobile_client/presentation/features/contact_us/contact_us.dart';
import 'package:mobile_library/mobile_library.dart';
import 'package:url_launcher/url_launcher.dart';

/// Support phone number
const supportPhoneNumber = '+222 07 78 47 63 10';

/// Support email
const supportEmail = 'support@nashcrate.com';

/// Contact us header
class ContactUsHeader extends StatelessWidget {
  /// constructor
  const ContactUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HSB(100.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 40.h),
          child: Text(
            t.contactUs.description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color.fromRGBO(58, 58, 58, 1),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 80.w, vertical: 40.h),
          child: Row(
            children: [
              // phone
              Expanded(
                child: ContactUsSupportCard(
                  title: t.contactUs.support.phone,
                  data: supportPhoneNumber,
                  svgIcon: AppSvgImage(Assets.contactUs.calling.path, width: 80.w),
                  onPressed: () async {
                    const notifyGroupKey = 'support';
                    clearAllGroupNotifications(notifyGroupKey);

                    const url = 'tel:$supportPhoneNumber';
                    if (!await launchUrl(Uri.parse(url))) {
                      showErrorNotification(
                        t.errors.failures.unableToProcess,
                        groupKey: notifyGroupKey,
                      );
                    }
                  },
                ),
              ),

              WSB(40.w),

              // email
              Expanded(
                child: ContactUsSupportCard(
                  title: t.contactUs.support.email,
                  data: supportEmail,
                  svgIcon: AppSvgImage(Assets.contactUs.mail.path, width: 80.w),
                  onPressed: () async {
                    const url = 'mailto:$supportEmail';
                    if (!await launchUrl(Uri.parse(url))) {
                      showErrorNotification(t.errors.failures.unableToProcess);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
