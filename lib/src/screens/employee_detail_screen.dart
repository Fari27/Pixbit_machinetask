import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/src/base/base_page.dart';
import 'package:sample/src/models/get_employees_model.dart';
import 'package:sample/src/util/app_colors.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:sample/src/util/app_sizes.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen(this.arguments, {super.key});

  final Map<String, dynamic>? arguments;

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  EmployeesList? employeeDetails;
  @override
  void initState() {
    if (widget.arguments != null) {
      employeeDetails = widget.arguments!['employeeDetails'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: _getBody(context),
      padding: EdgeInsets.only(
          right: AppWidgetSizes.dimen_16,
          left: AppWidgetSizes.dimen_16,
          top: AppWidgetSizes.dimen_16,
          bottom: AppWidgetSizes.dimen_16),
      menuRequired: false,
      appBarType: AppBarType.backWithTitle,
      title: '${employeeDetails?.firstName} ${employeeDetails?.lastName}',
    );
  }

  _getBody(BuildContext context) {
    return Column(
      children: [
        Image.network(
          (employeeDetails?.profileImage ?? '').toString(),
          height: AppWidgetSizes.dimen_100,
          width: AppWidgetSizes.dimen_100,
          errorBuilder: (context, error, stackTrace) {
            return Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png',
              height: AppWidgetSizes.dimen_100,
              width: AppWidgetSizes.dimen_100,
            );
          },
        ),
        Text('${employeeDetails?.firstName} ${employeeDetails?.lastName}',
            style: Theme.of(context).textTheme.bodyLarge),
        Text('Supervisor',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: const Color.fromARGB(255, 132, 131, 131))),
        SizedBox(height: AppWidgetSizes.dimen_16),
        _getDetailsWidget(),
      ],
    );
  }

  _getDetailsWidget() {
    DateTime dateTime = DateTime.parse(employeeDetails!.dateOfBirth.toString());

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return Container(
      padding: EdgeInsets.only(
          right: AppWidgetSizes.dimen_16,
          left: AppWidgetSizes.dimen_16,
          top: AppWidgetSizes.dimen_16,
          bottom: AppWidgetSizes.dimen_16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlueAccent)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getColumnWidget(
                  'Contact Number', employeeDetails!.mobile.toString()),
              _getColumnWidget('Email', employeeDetails!.email.toString()),
            ],
          ),
          SizedBox(height: AppWidgetSizes.dimen_16),
          Padding(
            padding: EdgeInsets.only(right: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getColumnWidget('Date of birth', formattedDate),
                _getColumnWidget('Gender', employeeDetails!.gender.toString()),
              ],
            ),
          ),
          SizedBox(height: AppWidgetSizes.dimen_16),
          Row(
            children: [
              _getColumnWidget(
                  'Address', employeeDetails!.permanentAddress.toString())
            ],
          )
        ],
      ),
    );
  }

  _getColumnWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Appcolors.blackColor,
                fontSize: AppWidgetSizes.dimen_12,
              ),
        ),
        SizedBox(height: AppWidgetSizes.dimen_8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Appcolors.blackColor,
                fontSize: AppWidgetSizes.dimen_14,
              ),
        ),
      ],
    );
  }
}
