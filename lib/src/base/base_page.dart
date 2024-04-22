import 'package:flutter/material.dart';
import 'package:sample/src/constants/image_constants.dart';
import 'package:sample/src/theme/light_theme.dart';
import 'package:sample/src/util/app_colors.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:sample/src/util/app_navigation.dart';
import 'package:sample/src/util/app_routes.dart';
import 'package:sample/src/util/app_sizes.dart';



class BasePage extends StatelessWidget {
  const BasePage(
      {super.key,
      this.title,
      this.titleWidget,
      this.subtitle,
      required this.body,
      this.footer,
      required this.padding,
      this.preferredHeight,
      this.resizeToAvoidBottomInset,
      this.appBar,
      this.menuRequired = false,
      this.appBarType = AppBarType.backWithTitle,
      this.actions,
      this.tapOnClose,
      this.noScrollableScrollPhysics = false,
      this.customScrollRequired = true,
      this.footerWithNoBg = false,
      this.preferredSizeWidget,
      this.scrollController,
      this.selectedTabIndex = 0,
      this.floatingActionButton});
  final bool? menuRequired;
  final bool? noScrollableScrollPhysics;
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget body;
  final Widget? footer;
  final Widget? appBar;
  final EdgeInsets padding;
  final double? preferredHeight;
  final bool? resizeToAvoidBottomInset;
  final AppBarType appBarType;
  final List<Widget>? actions;
  final Function()? tapOnClose;
  final bool? customScrollRequired;
  final bool? footerWithNoBg;
  final PreferredSizeWidget? preferredSizeWidget;
  final ScrollController? scrollController;
  final int selectedTabIndex;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    if (menuRequired == true) {
      return Scaffold(
        appBar: getAppBar(context),
        body: Container(child: getBody(context)),
        bottomNavigationBar: footer,
        floatingActionButton: floatingActionButton,
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar(context),
      body: getBody(context),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      bottomNavigationBar: _getFooter(context),
      floatingActionButton: floatingActionButton,
    );
  }

  _getFooter(BuildContext context) {
    if (footer != null) {
      if (footerWithNoBg == true) {
        return Container(
            decoration: BoxDecoration(
              color: Appcolors.bottomSheetBgColor(context),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 9, // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SafeArea(child: footer!),
            ));
      } else {
        return Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       alignment: Alignment.centerLeft,
          //       image: AssetImage(ImageConstants.background(context)),
          //       fit: BoxFit.cover),
          // ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SafeArea(bottom: true, child: footer!),
          ),
        );
      }
    }
    const SizedBox.shrink();
  }

  dynamic getAppBar(BuildContext context) {
    if (appBar != null) {
      return appBar;
    }
    if (preferredSizeWidget != null) {
      return _getAppBar(context);
    }
    return PreferredSize(
        preferredSize: preferredHeight == null
            ? const Size.fromHeight(52)
            : Size.fromHeight(preferredHeight!),
        child: _getAppBar(context));
  }

  _getAppBar(BuildContext context) {
    switch (appBarType) {
      case AppBarType.backWithTitle:
        {
          return _appBarWithBackAndTitle(context);
        }
      case AppBarType.empty:
        {
          return const SizedBox.shrink();
        }
      case AppBarType.backWithAction:
        {
          return _appBarBackWithAction(context);
        }

      default:
        {
          return _appBarWithTitleAndClose(context);
        }
    }
  }

  _appBarBackWithAction(BuildContext context) {
    return AppBar(
        bottom: (preferredSizeWidget != null)
            ? preferredSizeWidget
            : PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(),
              ),
        leading: _getBackButton(context),
        centerTitle: false,
        backgroundColor: Appcolors.appBarBgColor(context).withOpacity(0.4),
        elevation: 0.5,
        titleSpacing:
            titleWidget != null ? 0.0 : NavigationToolbar.kMiddleSpacing,
        flexibleSpace: _getBackGroundImage(context),
        title: titleWidget ??
            Text(
              title ?? "",
              style: Theme.of(context).textTheme.displaySmall,
            ),
        actions: actions);
  }

  _getBackGroundImage(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage(ImageConstants.background(context)),
          fit: BoxFit.cover),
    ));
  }

  _appBarWithTitleAndClose(BuildContext context) {
    return AppBar(
      bottom: (preferredSizeWidget != null)
          ? preferredSizeWidget
          : PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(),
            ),
      leadingWidth: 0,
      leading: Container(),
      centerTitle: false,
      backgroundColor: Appcolors.appBarBgColor(context).withOpacity(0.4),
      elevation: 0.5,
      flexibleSpace: Container(
          decoration: BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(ImageConstants.background(context)),
            fit: BoxFit.cover),
      )),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          // IconButton(
          //     onPressed: (tapOnClose != null)
          //         ? tapOnClose!
          //         : () {
          //       NavigationService().popNavigation();
          //     },
          //     icon: SvgPicture.asset(ImageConstants.close(context),)),
        ],
      ),
    );
  }

  _appBarWithBackAndTitle(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: Appcolors.appBarBgColor(context).withOpacity(0.4),
      flexibleSpace: Container(
          decoration: BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(ImageConstants.background(context)),
            fit: BoxFit.cover),
      )),
      elevation: 0.0,
      leading: _getBackButton(context),
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      actions: actions,
    );
  }

  _getBackButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        NavigationService().popNavigation();
      },
      icon: const Icon(Icons.arrow_back_ios,size: 16,),
    );
  }

  Widget getBody(BuildContext context) {

    if(Screenroutes == 'login'){
       return Container(
      color: Colors.amber,

      
      child: (customScrollRequired == true)
          ? CustomScrollView(
              controller: scrollController,
              physics: (noScrollableScrollPhysics == true)
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: padding,
                  sliver: SliverToBoxAdapter(
                    child: SafeArea(child: body),
                  ),
                ),
              ],
            )
          : SafeArea(
              child: SizedBox(
                  height: AppWidgetSizes.screenHeight(context), child: body)),
    );
    }
    return Container(
      color: LightTheme.textWhiteColor,

      
      child: (customScrollRequired == true)
          ? CustomScrollView(
              controller: scrollController,
              physics: (noScrollableScrollPhysics == true)
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: padding,
                  sliver: SliverToBoxAdapter(
                    child: SafeArea(child: body),
                  ),
                ),
              ],
            )
          : SafeArea(
              child: SizedBox(
                  height: AppWidgetSizes.screenHeight(context), child: body)),
    );
  }
}
