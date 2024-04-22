import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/blocs/employee_bloc/employee_bloc.dart';
import 'package:sample/src/blocs/login_bloc/login_bloc.dart';
import 'package:sample/src/constants/string_constants.dart';
import 'package:sample/src/screens/add_employee_screen.dart';
import 'package:sample/src/screens/employee_detail_screen.dart';
import 'package:sample/src/screens/employee_screen.dart';
import 'package:sample/src/screens/login_screen.dart';

class Screenroutes {
  static final RouteObserver<PageRoute> routeobserver =
      RouteObserver<PageRoute>();

  static const String login = "login";
  static const String employee = "employee";
  static const String addemployee = "addemployee";
  static const String employeedetails = "employeedetails";
  static Route<dynamic>? routes(RouteSettings settings) {
    StringConstants.currentRoute = settings.name ?? "";

    switch (settings.name) {
      case Screenroutes.login:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Screenroutes.login),
            builder: (BuildContext context) {
              return BlocProvider(
                create: (context) => LoginBloc(),
                child: const LoginScreen(),
              );
            });

      case Screenroutes.employee:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Screenroutes.employee),
            builder: (BuildContext context) {
              return BlocProvider(
                  create: (context) => EmployeeBloc(),
                  child: const EmployeeScreen());
            });
      case Screenroutes.employeedetails:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Screenroutes.employeedetails),
            builder: (BuildContext context) {
              final dynamic arguments = settings.arguments;
              return EmployeeDetailScreen(arguments);
            });

      case Screenroutes.addemployee:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Screenroutes.addemployee),
            builder: (BuildContext context) {
              return BlocProvider(
                  create: (context) => EmployeeBloc(),
                  child: const AddEmployeeScreen());
            });
    }
    return null;
  }
}
