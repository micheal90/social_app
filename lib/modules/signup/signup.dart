import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:social_app/layout/home_layout/home_layout.dart';
import 'package:social_app/modules/signup/cubit/signup_cubit.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/services/local/cash_helper.dart';
import 'package:social_app/shared/widgets/default_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup_screen';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  void _submit(context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    SignupCubit.get(context).userSignUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupCreateSuccces) {
            CashHelper.putData(key: 'uId', value: state.uId).then((value){
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
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
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
                            'SIGNUP',
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
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onChanged: (String value) {
                            print(value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Name must be entered';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          obscureText: SignupCubit.get(context).isPassword,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onChanged: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: InkWell(
                              onTap: () => SignupCubit.get(context)
                                  .changePasswordVisability(),
                              child: Icon(
                                SignupCubit.get(context).suffix,
                              ),
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
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          onChanged: (String value) {
                            print(value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Phone must be entered';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        BuildCondition(
                          condition: state is SignupLoading,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          fallback: (context) => DefaultButton(
                            width: double.infinity,
                            text: 'SIGNUP',
                            onPressed: () => _submit(context),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'LogIn',
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
