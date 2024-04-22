import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/base/base_page.dart';
import 'package:sample/src/blocs/login_bloc/login_bloc.dart';
import 'package:sample/src/constants/string_constants.dart';
import 'package:sample/src/util/app_colors.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:sample/src/util/app_navigation.dart';
import 'package:sample/src/util/app_routes.dart';
import 'package:sample/src/util/app_sizes.dart';
import 'package:sample/src/util/input_validator.dart';
import 'package:sample/src/widgets/button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userIdTextField = TextEditingController();

  final TextEditingController pwdTextField = TextEditingController();
  String? _errorText;
  String? _usernameErrorText;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: _getBody(context),
      padding: EdgeInsets.only(top: AppWidgetSizes.dimen_20),
      menuRequired: false,
      appBarType: AppBarType.empty,
      preferredHeight: AppWidgetSizes.dimen_60,
    );
  }

  _getBody(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginAuthenticationState) {
          NavigationService().pushNavigation(Screenroutes.employee);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
              child: Column(
               
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Appcolors.textDarkBlueColor)),
                  AppWidgetSizes.verticalSpace10,
                  Text('Please login to your account',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: Appcolors.textDarkBlueColor)),
                ],
              ),
            ),
            AppWidgetSizes.verticalSpace150,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(color: Colors.blueAccent.withAlpha(40),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.only(right: 20, left: 20,top: 40),
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (val) {
                              _pwdValidation(context: context);
                            },
                            validator: (value) {
                              _usernameErrorText =
                                  InputValidator.validateUsername(
                                      value ?? '');
                              return _usernameErrorText;
                            },
                            //  inputFormatters: InputValidator.userIdValidator(),
                            cursorColor: Appcolors.blackColor,
                            style: Theme.of(context).textTheme.bodyMedium,
                            controller: userIdTextField,
                            decoration: InputDecoration(
                              
                            filled: true,
                            fillColor: Colors.white,
                                errorText: _usernameErrorText,
                                prefixIcon: Icon(Icons.mail_outline_outlined),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Appcolors.textLightGrayColor(
                                            context),
                                        fontSize: AppWidgetSizes.fontSize14),
                                border: InputBorder.none,
                                hintText: 'Username'),
                          ),
                          AppWidgetSizes.verticalSpace20,
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (val) {
                              _pwdValidation(context: context);
                            },
                            validator: (value) {
                              _errorText = InputValidator.validatePassword(
                                  value ?? '');
                              return _errorText;
                            },
                            cursorColor: Appcolors.blackColor,
                            controller: pwdTextField,
                            style: Theme.of(context).textTheme.bodyMedium,
                            obscureText: state.obsecureEnabled,
                            maxLength: 15,
                            decoration: InputDecoration(
                                filled: true,
                            fillColor: Colors.white,
                              prefixIcon: Icon(Icons.key_sharp),
                              errorText: _errorText,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Appcolors.textLightGrayColor(
                                          context),
                                      fontSize: AppWidgetSizes.fontSize14),
                              hintText: 'Password',
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                          AppWidgetSizes.verticalSpace28,
                          _loginButtonWidget(context: context),
                          AppWidgetSizes.verticalSpace50,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _pwdValidation({required BuildContext context}) {
    if (pwdTextField.text.length > 5 && userIdTextField.text.length > 7) {
      context.read<LoginBloc>().add(ButtonEnableEvent(buttonEnabled: true));
    } else {
      context.read<LoginBloc>().add(ButtonEnableEvent(buttonEnabled: false));
    }
  }

  _loginButtonWidget({required BuildContext context}) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (context, state) {
        return state is ButtonEnableState;
      },
      builder: (context, state) {
        return (state.buttonEnabled)
            ? ButtonWidget(
                text: "Sign in",
                buttonState: ElevatedButtonState.active,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    var arg = {
                      "email": userIdTextField.text,
                      "password": pwdTextField.text,
                    };
                    context
                        .read<LoginBloc>()
                        .add(LoginRequestEvent(reqParams: arg));
                  }
                },
              )
            : ButtonWidget(
                text: 'Sign in',
                buttonState: ElevatedButtonState.disable,
                onPressed: () {},
              );
      },
    );
  }
}
