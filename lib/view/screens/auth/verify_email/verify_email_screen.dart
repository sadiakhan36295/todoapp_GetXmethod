import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/view/controllers/verify_email_controller.dart'; // Adjust path as needed

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key, String? email}) {
    // If an email is passed during navigation, initialize the controller with it.
    // This is an alternative to using Get.arguments if you prefer direct constructor passing.
    // If you pass via Get.arguments from SignUp, remove this 'email' parameter.
    final VerifyEmailController controller = Get.put(VerifyEmailController());
    if (email != null && email.isNotEmpty) {
      controller.emailController.text = email;
    }
  }

  @override
  Widget build(BuildContext context) {
    // We put the controller here if it wasn't injected in the constructor
    // Or if you are relying solely on Get.find() after Get.put elsewhere.
    final VerifyEmailController controller = Get.find<VerifyEmailController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100), // Adjust spacing as per image
            const Text(
              "Verify Your Email",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "We'll send a verification code to this email to confirm your account.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            _buildLabel("Email Address"),
            _buildTextField(controller.emailController, "michelle.rivera@example.com"), // Hint text from image

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => controller.sendVerificationEmail(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Send",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 6),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress, // Set keyboard type for email
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // Changed from white60 to white for consistency with image
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}