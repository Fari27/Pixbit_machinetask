import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/base/base_page.dart';
import 'package:sample/src/blocs/employee_bloc/employee_bloc.dart';
import 'package:sample/src/models/get_employees_model.dart';
import 'package:sample/src/util/app_colors.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:sample/src/util/app_navigation.dart';
import 'package:sample/src/util/app_routes.dart';
import 'package:sample/src/util/app_sizes.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<EmployeesList> employeesList = [];
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(GetEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: _getBody(context),
      customScrollRequired: false,
      padding: EdgeInsets.only(
          right: AppWidgetSizes.dimen_16,
          left: AppWidgetSizes.dimen_16,
          top: AppWidgetSizes.dimen_16,
          bottom: AppWidgetSizes.dimen_16),
      menuRequired: false,
      appBarType: AppBarType.backWithTitle,
      title: 'Employee',
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(240, 4, 140, 251),
        shape: const CircleBorder(),
        onPressed: () {
          NavigationService().pushNavigation(Screenroutes.addemployee);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  _getBody(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
      if(state.status.isLoading){
         return SizedBox(
              height: AppWidgetSizes.dimen_600,
              child: Center(
                child: CupertinoActivityIndicator(
                    color: Appcolors.loadingColor(context)),
              ));
      }
      if (state is GetEmployeeState && state.status.isSuccess) {
        employeesList = state.resp ?? [];
      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: employeesList.length,
        itemBuilder: (context, index) {
          EmployeesList item = employeesList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.only(
                  right: AppWidgetSizes.dimen_16, 
                  left: AppWidgetSizes.dimen_16,
                  top: AppWidgetSizes.dimen_10),
              child: InkWell(
                onTap: () {
                  var arg = {
                    "employeeDetails": item,
                  };
                  NavigationService().pushNavigation(
                      Screenroutes.employeedetails,
                      arguments: arg);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      item.profileImage.toString(),
                      height: AppWidgetSizes.dimen_50,
                      width: AppWidgetSizes.dimen_50,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png',
                          height: AppWidgetSizes.dimen_50,
                          width: AppWidgetSizes.dimen_50,
                        );
                      },
                    ),
                    SizedBox(width: AppWidgetSizes.dimen_10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.firstName} ${item.lastName}',
                            style: Theme.of(context).textTheme.bodyLarge),
                        SizedBox(height: AppWidgetSizes.dimen_3),
                        Text(
                          item.mobile.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Appcolors.textColor(context)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
      }
       return const SizedBox();
    });
  }
}
