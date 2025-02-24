import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';
import 'package:smartroombooking/features/on_boarding/presentation/provider/on_boarding_provider.dart';
import 'package:smartroombooking/features/on_boarding/presentation/widgets/custom_on_boarding_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnBoardingProvider(),
      child: Consumer<OnBoardingProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: provider.pageController,
                        itemCount: provider.onBoardingData.length,
                        onPageChanged: provider.updatePage,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            child: CustomOnBoardingContent(
                              onBoardingImgPath:
                                  provider.onBoardingData[index]["image"]!,
                              onBoardingTitle:
                                  provider.onBoardingData[index]["title"]!,
                              onBoardingSubTitle:
                                  provider.onBoardingData[index]["subtitle"]!,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: provider.skipToLastPage,
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontFamily: "Redhat",
                                fontWeight: FontWeight.w700,
                                color: AppColors.titleColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: provider.pageController,
                            count: provider.onBoardingData.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: AppColors.primaryColor,
                              dotHeight: 6.h,
                              dotWidth: 6.w,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (provider.currentPage ==
                                  provider.onBoardingData.length - 1) {
                                /// user type screen
                                GoRouter.of(
                                  context,
                                ).pushReplacementNamed("userTypeScreen");
                              } else {
                                provider.nextPage();
                              }
                            },
                            child: Text(
                              provider.currentPage ==
                                      provider.onBoardingData.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: TextStyle(
                                fontFamily: "Redhat",
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
