import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/utils.dart';
import 'package:social_app/layout/home_layout/home_layout.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/signup/signup.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/services/local/cash_helper.dart';
import 'package:social_app/shared/widgets/default_button.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  static const routeName = '/login_screen';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  void _submit(context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    LoginCubit.get(context).userLogin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccces) {
            CashHelper.putData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const HomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
           // backgroundColor: KBackgroungColor,
            appBar: AppBar(
             // backgroundColor: KBackgroungColor,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: SvgPicture.asset('assets/images/login.svg')),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now to comunicate with your friends.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onChanged: (String value) {
                            print(value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? val) {
                            if (!GetUtils.isEmail(val!)) {
                              return 'Incorrect email, provide email in avalid format';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: LoginCubit.get(context).isPassword,
                          onFieldSubmitted: (_) => _submit(context),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: InkWell(
                              onTap: () => LoginCubit.get(context)
                                  .changePasswordVisability(),
                              child: Icon(LoginCubit.get(context).suffix),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (String? val) {
                            if (val!.length < 6) {
                              return 'The password is too short';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        BuildCondition(
                          condition: state is LoginLoading,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          fallback: (context) => DefaultButton(
                              width: double.infinity,
                              text: "LOGIN",
                              onPressed: () => _submit(context)),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () =>
                                  navigateTo(context, SignUpScreen()),
                              child: const Text(
                                'Register Now',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
