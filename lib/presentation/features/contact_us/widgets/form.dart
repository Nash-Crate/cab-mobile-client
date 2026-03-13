import 'package:flutter/material.dart';
import 'package:mobile_client/i18n/translations.g.dart';
import 'package:mobile_library/mobile_library.dart';

/// Contact us form
class ContactUsForm extends StatelessWidget {
  /// constructor
  const ContactUsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HSB(50.h),
          BorderWrapper(
            child: PhoneNumberField(
              controller: TextEditingController(text: 'TODO'),
              callingCode: '+94', // TODO(contactUs): callingCode
              label: t.contactUs.form.phone.label,
              hint: t.contactUs.form.phone.hint,
              isFloatingLabel: true,
              onChanged: (String value) {
                // TODO(contactUs): onChange
              },
              onCountryChanged: (String value) {
                // TODO(contactUs): onCountryChanged
              },
            ),
          ),
          HSB(50.h),
          BorderWrapper(
            child: AppTextField(
              label: t.contactUs.form.email.label,
              hint: t.contactUs.form.email.hint,
              keyboardType: TextInputType.emailAddress,
              isFloatingLabel: true,
            ),
          ),
          HSB(50.h),
          BorderWrapper(
            child: AppTextField(
              label: t.contactUs.form.message.label,
              hint: t.contactUs.form.message.hint,
              isFloatingLabel: true,
              minLines: 5,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          HSB(50.h),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    // TODO(contactUs): onSubmit
                  },
                  child: Text(t.common.actions.submit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
