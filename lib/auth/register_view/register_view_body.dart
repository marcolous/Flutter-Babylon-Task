import 'package:babylon_task/core/utils/routes.dart';
import 'package:babylon_task/core/utils/show_snack_bar.dart';
import 'package:babylon_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({
    super.key,
  });

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, Routes.kHomeScreen);
          setState(() {
            isLoading = false;
          });
        } else if (state is RegisterFailure) {
          ShowSnackBar.show(context, state.errMsg);
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const CustomBackButton(),
                  const Gap(28),
                  Text(
                    'Hello! Register to get started',
                    style: Style.style30(context),
                  ),
                  const Gap(32),
                  EmailTextField(hintText: 'Username', controller: _userName),
                  const Gap(12),
                  EmailTextField(hintText: 'Email', controller: _email),
                  const Gap(12),
                  PasswordTextField(
                      hintText: 'Password', controller: _password),
                  const Gap(12),
                  PasswordTextField(
                      hintText: 'Confirm password', controller: _confirmPass),
                  const Gap(15),
                  const UnVerifiedEmailWidget(),
                  const Gap(15),
                  CustomProgressIndicator(
                    isLoading: isLoading,
                    child: CustomButton(
                      title: 'Register',
                      onPressed: () => _register(
                          email: _email.text.trim(), password: _password.text),
                    ),
                  ),
                  const Gap(35),
                  const CustomOrWith(title: 'Or Register with'),
                  const Gap(22),
                  const CustomGoogleButton(),
                  CustomRow(
                    title: 'Already have an account? ',
                    subTitle: 'Login Now',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.kLoginScreen);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _register({required String email, required String password}) async {
    if (_password.text != _confirmPass.text) {
      ShowSnackBar.show(context, 'Password doesn\'t match');
      return;
    }
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .register(email: email, password: password);
    }
  }
}
