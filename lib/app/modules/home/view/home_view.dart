import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_grid_widget.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_list_widget.dart';
import 'package:mobileapphigertech/app/modules/map/widget/station_map_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran screen
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: size.height * 0.07, 
        title: Image.asset(
          'assets/higertech.png',
          height: size.height * 0.04, 
          fit: BoxFit.contain,
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          
          return await Future.delayed(const Duration(seconds: 1));
        },
        child: SafeArea(
          child:
              isTablet
                  ? _buildTabletLayout(context, size)
                  : _buildMobileLayout(context, size),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.02,
      ),
      child: Column(
        children: [
    
          SizedBox(
            height: size.height * 0.35,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GetBuilder<HomeController>(
                      builder:
                          (controller) =>
                              StationMapWidget(markers: controller.markers),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
               
                const Expanded(flex: 2, child: StationOverviewGrid()),
              ],
            ),
          ),

          SizedBox(height: size.height * 0.02),

          Expanded(child: StationListWidget(showSearch: false)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size size) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
              size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
            horizontal: size.width * 0.03,
          ),
          child: Column(
            children: [
        
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height:
                      size.height * 0.25,
                  width: double.infinity,
                  child: GetBuilder<HomeController>(
                    builder: (controller) {
                      return StationMapWidget(
                        height: 400,
                        markers: controller.markers,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.015),

              const StationOverviewGrid(),

              SizedBox(height: size.height * 0.015),

          
              SizedBox(
                height: size.height * 0.5, 
                child: StationListWidget(showSearch: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StationOverviewGridExt on StationOverviewGrid {
  Widget withResponsiveHeight(double height) {
    return SizedBox(height: height, child: this);
  }
}
