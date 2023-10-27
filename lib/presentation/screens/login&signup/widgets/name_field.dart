import 'package:flutter/material.dart';
import 'package:motox/presentation/widgets/custom_textfield.dart';
import 'package:motox/utils/colors/colors.dart';
import 'package:motox/utils/constants/enums.dart';
import 'package:motox/utils/helpers/validators.dart';

Widget buildNameField(AuthenticationPage authenticationPage,
    TextEditingController nameController) {
  return CustomTextField(
    validator: validateName,
    text: 'Name',
    prefixIcon: Icon(
      Icons.perm_identity,
      color: greyColor,
    ),
    controller: nameController,
  );
}
