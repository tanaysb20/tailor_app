
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/Screens/Home%20screen/home_screen.dart';
import 'package:tailor_app/Screens/My%20customer/customer_screen.dart';
import 'package:tailor_app/Screens/My%20Orders/orders_screen.dart';
import 'package:tailor_app/main.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  int indexx = 0;
  int currentIndexx = 0;
  int tab = 1;
  TabController? _tabController;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    // setState(() {
    //   loading = true;
    // });
    // Provider.of<HomeProvider>(context, listen: false)
    //     .getCategories()
    //     .then((value) {
    //   if (Provider.of<HomeProvider>(context, listen: false)
    //       .categoryList
    //       .isNotEmpty) {
    //     Provider.of<HomeProvider>(context, listen: false).getCategoriesItems(
    //         Provider.of<HomeProvider>(context, listen: false)
    //             .categoryList[0]
    //             .id);
    //   }
    // }).then((value) {
    //   setState(() {
    //     loading = false;
    //   });
    // });
  }

  @override
  void dispose() {
    _tabController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return 
    
    Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 20.w,
        centerTitle: false,
        title: currentIndexx == 0
            ?  Row(
              children: [
                SvgPicture.asset("assets/logohome.svg",height: 35.h,fit: BoxFit.cover),
                SizedBox(width: 8.w),
                Text("Tailor App",  style: TextStyle(
                  fontSize: 24.sp,
                  color: const Color(0xffFF7126),
                  fontWeight: FontWeight.w500,
                ),)
              ],
            )
            : Text(
               currentIndexx == 1
                    ? "My Orders":
                 "My Customers",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: const Color(0xffFF7126),
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          if (currentIndexx == 0)
            InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) {
                          return MyApp();
                        },
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Icon(Icons.logout,
                    color: const Color.fromARGB(255, 207, 14, 0),
                    size: 28.sp,
                    weight: 10)),
          SizedBox(width: 20.w)
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(color: const Color(0xffFF7126)))
          : currentIndexx == 0
              ? const HomeScreen()
              : currentIndexx == 1
                  ? RelativesScreen()
                  : const CustomerScreen(),
      bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: const IconThemeData(
            color: Color(0xffFF7126),
            
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/home.svg", height: 40.h),
              activeIcon: SvgPicture.asset("assets/home.svg",
                  height: 40.h, color: Color(0xffFF7126)),
              label: 'Home',
              
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/tab2.svg", height: 40.h),
                activeIcon: SvgPicture.asset("assets/tab2.svg",
                    height: 40.h, color: Color(0xffFF7126)),
                label: "My Orders"),
          
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/tab3.svg", height: 40.h),
              activeIcon: SvgPicture.asset("assets/tab3.svg",
                  // ignore: deprecated_member_use
                  height: 40.h,
                  color: Color(0xffFF7126)),
              label: 'My Customers',
              
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndexx,
          selectedItemColor: Color(0xffFF7126),
          iconSize: 40.sp,
          onTap: (value) {
            currentIndexx = value;
            setState(() {});
          },
          elevation: 5),
    );
  }
}
