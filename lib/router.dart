import 'package:flutter/material.dart';
import 'package:plantify/features/order_and_e-eeceipt/presentation/my_order_tracking/view/myorder_tracking_screen.dart';
import 'package:plantify/features/order_and_e-eeceipt/presentation/myorder_live_tracking/myorder_live_tracking_screen.dart';
import 'package:plantify/features/profile_and_setting/customer_service/customer_service.dart';
import 'package:plantify/features/profile_and_setting/help_center/contact_us/contact_us.dart';
import 'package:plantify/features/profile_and_setting/help_center/help_center_faq/help_center_faq_screen.dart';
import 'package:plantify/features/profile_and_setting/setting_notification/setting_notification_screen.dart';
import 'package:plantify/features/profile_and_setting/vouher_list/voucher_list_screen.dart';
import 'package:plantify/features/scan/scan_screen.dart';
import 'app/main_wrapper.dart';
import 'features/auth/presentation/create_account/presentation/view/create_account_screen.dart';
import 'features/auth/presentation/login_account/presentation/view/login_account_screen.dart';
import 'features/auth/presentation/welcome_screen/presentation/view/welcome_screen.dart';
import 'features/detail_plant/presentation/detail_review/detail_plant_review_screen.dart';
import 'features/detail_plant/presentation/plant_detail/plant_detail_screen.dart';
import 'features/forgot_password_pages/new_password/presentation/view/new_password_screen.dart';
import 'features/forgot_password_pages/new_password/presentation/widgets/success_popup.dart';
import 'features/home/presentation/favorite_plant/view/favorite_plant_screen.dart';
import 'features/home/presentation/home/view/home_screen.dart';
import 'features/home/presentation/home_notification/view/home_notification_screen.dart';
import 'features/home/presentation/model/product_ui_model.dart';
import 'features/list_plant/presentation/availble_plant/view/availble_plant_screen.dart';
import 'features/my_cart_and_transaction/presentation/view/checkout_blank_screen/view/mycart_checkout_blank_screen.dart';
import 'features/my_cart_and_transaction/presentation/view/my_cart_list/view/my_cart_list_screen.dart';
import 'features/my_cart_and_transaction/presentation/view/mycart_checkout_enterpayment/enter_payment_screen.dart';
import 'features/my_cart_and_transaction/presentation/view/mycart_checkout_selectaddress_/checkout_select_address_screen.dart';
import 'features/my_cart_and_transaction/presentation/view/mycart_checkoutz_select_shipping/checkout_select_shipping_screen.dart';
import 'features/onboarding/onboarding/presentation/view/onboarding_screen.dart';
import 'features/onboarding/splash/presentation/view/splash_screen.dart';
import 'features/order_and_e-eeceipt/domain/entities/order_entity.dart';
import 'features/order_and_e-eeceipt/presentation/detail_e_receipt/detail_e_receipt_screen.dart';
import 'features/order_and_e-eeceipt/presentation/myorder_status/view/myorder_status_screen.dart';
import 'features/profile_and_setting/add_new_payment/add_new_payment_screen.dart';
import 'features/profile_and_setting/languages/setting_languages.dart';
import 'features/profile_and_setting/setting_security/setting_security_screen.dart';
import 'features/setup_profile_pages/add_new_address/presentation/view/add_new_address_screen.dart';
import 'features/setup_profile_pages/pin/presentation/view/pin_screen.dart';
import 'features/setup_profile_pages/pin/presentation/widget/pin_success_popup.dart';
import 'features/setup_profile_pages/setup_profile/presentation/view/setup_profile_screen.dart';
import 'features/forgot_password_pages/forgot_password/presentation/view/forgot_password_screen.dart';
import 'features/forgot_password_pages/forgot_password_otp/presentation/view/forgot_password_otp_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String createAccount = '/createAccount';
  static const String loginAccount = '/loginAccount';
  static const String forgotPassword = '/forgotPassword';
  static const String forgotPasswordOtp = '/forgotPasswordOtp';
  static const String newPassword = '/newPassword';
  static const String successPopup = '/successPopup';
  static const String setupProfile = '/setupProfile';
  static const String addNewAddress = '/addNewAddress';
  static const String pinScreen = '/pinScreen';
  static const String mainWrapper = '/mainWrapper';
  static const String homeScreen = '/homeScreen';
  static const String homenotifictionscreen = '/homenotifictionscreen';
  static const String favoriteplantscreen = '/favoriteplantscreen';
  static const String availablePlants = '/availablePlants';
  static const String plantDetail = '/plantDetail';
  static const String detailreview = '/detailreview';
  static const String camerascan = '/camerascan';
  static const String checkoutBlankFullScreen = '/checkoutBlankFullScreen';
  static const String checkoutSelectShipping = '/checkoutSelectShipping';
  static const String myCartList = '/myCartList';
  static const String checkoutPayment = '/checkoutPayment';
  static const String checkoutSelectAddress = '/checkoutSelectAddress';
  static const String detailereceipt = '/detailereceipt';
  static const String orderstatus = '/orderstatus';
  static const String ordertracking = '/ordertracking';
  static const String orderlivetracking = '/orderlivetracking';
  static const String voucherlist = '/voucherlist';
  static const String addnewpayment = '/addnewpayment';
  static const String settingnotification = '/settingnotification';
  static const String settingsecurity = '/settingsecurity';
  static const String helpcenterfaq = '/helpcenterfaq';
  static const String settinglanguage = '/settinglanguage';
  static const String contactus = '/contactus';
  static const String faq= '/faq';
  static const String customerservice= '/customerservice';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case createAccount:
        return MaterialPageRoute(builder: (_) => const CreateAccountScreen());

      case loginAccount:
        return MaterialPageRoute(builder: (_) => const LoginAccountScreen());

      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case forgotPasswordOtp:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordOtpScreen(),
          settings: settings, // VERY IMPORTANT
        );

      case successPopup:
        return MaterialPageRoute(builder: (_) => const SuccessPopup());

      case setupProfile:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SetupProfileScreen(
            isEditMode: args?['isEditMode'] ?? false,
          ),
        );

      case addNewAddress:
        return MaterialPageRoute(builder: (_) => const AddNewAddressScreen());

      case pinScreen:
        final flow = settings.arguments as SuccessPopupFlow;
        return MaterialPageRoute(
          builder: (_) => PinScreen(flow: flow),
        );

      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case homenotifictionscreen:
        return MaterialPageRoute(builder: (_) => const HomeNotificationScreen());

      case favoriteplantscreen:
        return MaterialPageRoute(builder: (_) => const FavoritePlantScreen());

      case availablePlants:
        return MaterialPageRoute(builder: (_) => const AvailablePlantsScreen());
      case camerascan:
        return MaterialPageRoute(builder: (_) => const PlantScanCameraScreen());
      case plantDetail:
        final product = settings.arguments as ProductUiModel;
        return MaterialPageRoute(
          builder: (_) => PlantDetailScreen(product: product),
        );
      case detailreview:
        return MaterialPageRoute(builder: (_) => const DetailPlantReviewScreen());
      case mainWrapper:
        return MaterialPageRoute(builder: (_) => const MainWrapper());

    // ✅ NEW CHECKOUT SCREEN ROUTES
      case checkoutBlankFullScreen:
        return MaterialPageRoute(builder: (_) => const CheckoutBlankFullScreen());

      case checkoutSelectShipping:
        return MaterialPageRoute(builder: (_) => const CheckoutSelectShippingScreen());

      case myCartList:
        return MaterialPageRoute(builder: (_) => const MyCartListScreen());

      case checkoutPayment:
        return MaterialPageRoute(builder: (_) => const CheckoutPaymentScreen());

      case checkoutSelectAddress:
        return MaterialPageRoute(builder: (_) => const CheckoutSelectAddressScreen());
      case detailereceipt:
        final order = settings.arguments as OrderEntity;

        return MaterialPageRoute(
          builder: (_) => DetailEReceiptScreen(order: order),
        );
      case orderstatus:
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());

      case ordertracking:
        return MaterialPageRoute(builder: (_) => const MyOrderTrackingScreen());

      case orderlivetracking:
        return MaterialPageRoute(builder: (_) => const MyOrderLiveTrackingScreen());

      case voucherlist:
        return MaterialPageRoute(builder: (_) => const VoucherListScreen());
      case addnewpayment:
        return MaterialPageRoute(builder: (_) => const AddPaymentMethodScreen());
      case settingnotification:
        return MaterialPageRoute(builder: (_) => const SettingNotificationScreen());

      case settingsecurity:
        return MaterialPageRoute(builder: (_) => const SettingSecurityScreen());

      case helpcenterfaq:
        return MaterialPageRoute(builder: (_) => const HelpCenterContactUsScreen());
      case settinglanguage:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());

      case contactus:
        return MaterialPageRoute(builder: (_) => const HelpCenterContactUsScreen());
      case faq:
        return MaterialPageRoute(builder: (_) => const HelpCenterFaqScreen());
      case customerservice:
        return MaterialPageRoute(builder: (_) => const CustomerServiceScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}