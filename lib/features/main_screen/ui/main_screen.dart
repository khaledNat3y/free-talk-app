import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk_app/core/helpers/app_assets.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/account_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/dictionary_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/settings_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/translate_screen.dart';
import '../../../core/theming/app_colors.dart';
import '../logic/theme_cubit/theme_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // FAB animation properties
  Offset _fabPosition = Offset.zero;
  Offset _defaultFabPosition = Offset.zero;
  bool _isDragging = false;
  AnimationController? _animationController;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Calculate default FAB position (center bottom)
    final size = MediaQuery.of(context).size;
    _defaultFabPosition = Offset(
      size.width / 2 - 28, // 28 is half of FAB size (56)
      size.height - 150, // Position above bottom nav
    );
    if (_fabPosition == Offset.zero) {
      _fabPosition = _defaultFabPosition;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      _fabPosition = Offset(
        (_fabPosition.dx + details.delta.dx).clamp(0, MediaQuery.of(context).size.width - 56),
        (_fabPosition.dy + details.delta.dy).clamp(0, MediaQuery.of(context).size.height - 200),
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    // Animate back to default position after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!_isDragging && mounted) {
        _animateToDefaultPosition();
      }
    });
  }

  void _animateToDefaultPosition() {
    _animation = Tween<Offset>(
      begin: _fabPosition,
      end: _defaultFabPosition,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOutBack,
    ));

    _animationController!.addListener(() {
      setState(() {
        _fabPosition = _animation!.value;
      });
    });

    _animationController!.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          backgroundColor: isDarkMode
              ? AppColors.scaffoldBackgroundDark
              : AppColors.scaffoldBackgroundLight,
          body: Stack(
            children: [
              SafeArea(
                child: Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (context) => BlocBuilder<ThemeCubit, bool>(
                        builder: (context, isDarkMode) {
                          return _buildCurrentScreen(isDarkMode);
                        },
                      ),
                    );
                  },
                ),
              ),

              // Draggable FAB
              Positioned(
                left: _fabPosition.dx,
                top: _fabPosition.dy,
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: AnimatedScale(
                    scale: _isDragging ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: FloatingActionButton(
                      onPressed: () {
                        // Your contact action here
                      },
                      backgroundColor: isDarkMode
                          ? AppColors.primaryDark
                          : AppColors.primary,
                      elevation: _isDragging ? 8 : 4,
                      child: Icon(
                        Icons.message,
                        color: AppColors.white,
                        size: 28.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.scaffoldBackgroundDark
                  : AppColors.scaffoldBackgroundLight,
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      svgPath: AppAssets.inActiveTranslateSvg,
                      label: 'Translate',
                      index: 0,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      svgPath: AppAssets.inActiveDictionarySvg,
                      label: 'Dictionary',
                      index: 1,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      svgPath: AppAssets.inActivePersonSvg,
                      label: 'Account',
                      index: 2,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      svgPath: AppAssets.inActiveGearSvg,
                      label: 'Settings',
                      index: 3,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentScreen(bool isDarkMode) {
    switch (_currentIndex) {
      case 0:
        return TranslateScreen(isDarkMode: isDarkMode);
      case 1:
        return DictionaryScreen(isDarkMode: isDarkMode);
      case 2:
        return const AccountScreen();
      case 3:
        return SettingsScreen(navigatorKey: _navigatorKey);
      default:
        return TranslateScreen(isDarkMode: isDarkMode);
    }
  }

  Widget _buildNavItem({
    String? svgPath,
    IconData? icon,
    required String label,
    required int index,
    bool isDarkMode = false,
  }) {
    final bool isSelected = _currentIndex == index;
    final Color itemColor = isSelected
        ? AppColors.white
        : isDarkMode
        ? AppColors.primaryDark
        : AppColors.primary;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 20.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? isDarkMode
                  ? AppColors.primaryDark
                  : AppColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: svgPath != null
                ? SvgPicture.asset(
              svgPath,
              width: 24.sp,
              height: 24.sp,
              colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
            )
                : Icon(
              icon ?? Icons.help_outline,
              color: itemColor,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(label, style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
    );
  }
}