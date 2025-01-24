import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/input_label.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: context.height),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Masuk Akun",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Untuk masuk, pastikan Anda telah memiliki akun di aplikasi",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const InputLabel(label: "NIK"),
                        const SizedBox(height: 4.0),
                        RoundedTextField(
                          controller: controller.nikController,
                          hintText: "Masukkan NIK Anda",
                          onChanged: (value) => controller.update(),
                          keyboardType: TextInputType.number,
                          maxLength: 16,
                        ),
                        const SizedBox(height: 16.0),
                        const InputLabel(label: "Password"),
                        const SizedBox(height: 4.0),
                        RoundedTextField(
                          controller: controller.passwordController,
                          hintText: "Masukkan Password Anda",
                          obscureText: true,
                          onChanged: (value) => controller.update(),
                        ),
                        const SizedBox(height: 24.0),
                        GetBuilder(
                          init: controller,
                          builder: (_) {
                            return RoundedButton(
                              title: "Masuk",
                              onPressed:
                                  controller.nikController?.text.isNotEmpty ==
                                              true &&
                                          controller.passwordController?.text
                                                  .isNotEmpty ==
                                              true
                                      ? controller.login
                                      : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
