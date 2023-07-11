import 'package:flutter/material.dart';
import '../../../shared/colors.dart';
import '../widgets/custom_login_text_field.dart';
import '../widgets/do_not_have_account_register.dart';
import '../widgets/elvated_button_register_page.dart';
import '../widgets/gaps.dart';
import '../widgets/gender_selection.dart';
import '../widgets/upload_image_widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: appbarbluegray,
        title: const Text("Register"),
        elevation: 0,
        // backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: const UploadingImage(),
                  ),
                  Gaps.vGap20,
                  CustomLoginTextField(
                    iconSuffix: const Icon(Icons.person),
                    textInputType: TextInputType.text,
                    obscureText: false,
                    stringInTextField: "Enter your name",
                    typeController: usernameController,
                  ),
                  CustomLoginTextField(
                    iconSuffix: const Icon(Icons.group_sharp),
                    textInputType: TextInputType.text,
                    obscureText: false,
                    stringInTextField: "Enter your class",
                    typeController: titleController,
                  ),
                  CustomLoginTextField(
                    iconSuffix: const Icon(Icons.email),
                    textInputType: TextInputType.text,
                    obscureText: false,
                    stringInTextField: "Enter your Email",
                    typeController: emailController,
                  ),
                  CustomLoginTextField(
                    iconSuffix: const Icon(Icons.lock),
                    textInputType: TextInputType.text,
                    obscureText: true,
                    stringInTextField: "Enter your Password",
                    typeController: passwordController,
                  ),
                  const TypeSelection(),
                  const ElvatedButtomRegister(),
                  Gaps.vGap10,
                  const DoNotHaveAccountRegister(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
