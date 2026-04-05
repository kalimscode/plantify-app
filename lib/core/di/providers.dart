import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/aichat/data/datasource/aichat_remote_datasource.dart';
import '../../features/aichat/data/repository/aichat_repository_impl.dart';
import '../../features/aichat/domain/repository/aichat_repository.dart';
import '../../features/aichat/presentation/viewmodel/aichat_viewmodel.dart';
import '../../features/auth/presentation/create_account/presentation/viewmodel/create_account_state.dart';
import '../../features/auth/presentation/create_account/presentation/viewmodel/create_account_viewmodel.dart';
import '../../features/auth/presentation/login_account/domain/models/login_account_model.dart';
import '../../features/auth/presentation/login_account/presentation/viewmodel/login_account_viewmodel.dart';
import '../../features/auth/presentation/welcome_screen/data/repositories/welcome_repository.dart';
import '../../features/auth/presentation/welcome_screen/domain/repositories/welcome_repository_impl.dart';
import '../../features/auth/presentation/welcome_screen/domain/welcome_state.dart';
import '../../features/auth/presentation/welcome_screen/presentation/viewmodel/welcome_viewmodel.dart';
import '../../features/forgot_password_pages/forgot_password/domain/entities/forgot_password_entity.dart';
import '../../features/forgot_password_pages/forgot_password/presentation/viewmodel/forgot_password_viewmodel.dart';
import '../../features/forgot_password_pages/forgot_password_otp/presentation/viewmodel/forgot_password_otp_state.dart';
import '../../features/forgot_password_pages/forgot_password_otp/presentation/viewmodel/forgot_password_otp_viewmodel.dart';
import '../../features/forgot_password_pages/new_password/domain/entities/password_entity.dart';
import '../../features/forgot_password_pages/new_password/presentation/viewmodel/new_password_viewmodel.dart';
import '../../features/home/data/datasources/LocalProductDataSource.dart';
import '../../features/home/data/datasources/product_remote_datasource.dart';
import '../../features/home/data/repositories/product_repositores_impl.dart';
import '../../features/home/domain/repositories/product_repository.dart';
import '../../features/home/presentation/favorite_plant/data/datasources/favourite_remote_datasource.dart';
import '../../features/home/presentation/home/viewmodel/home_viewmodel.dart';
import '../../features/home/presentation/model/product_ui_model.dart';
import '../../features/my_cart_and_transaction/data/datasources/cart_remote_datasource.dart';
import '../../features/my_cart_and_transaction/data/repositories/cart_repositories_impl.dart';
import '../../features/my_cart_and_transaction/domain/repositories/cart_repository.dart';
import '../../features/my_cart_and_transaction/presentation/viewmodel/cart_viewmodel/cart_view_model.dart';
import '../../features/my_cart_and_transaction/presentation/viewmodel/state/cart_state.dart';
import '../../features/onboarding/onboarding/data/onboarding_local_datasource.dart';
import '../../features/onboarding/onboarding/presentation/viewmodel/onboarding_state.dart';
import '../../features/onboarding/onboarding/presentation/viewmodel/onboarding_viewmodel.dart';
import '../../features/onboarding/splash/data/splash_repository_impl.dart';
import '../../features/onboarding/splash/domain/splash_usecase.dart';
import '../../features/onboarding/splash/presentation/viewmodel/splash_viewmodel.dart';
import '../../features/order_and_e-eeceipt/data/datasources/order_remote_datasource.dart';
import '../../features/order_and_e-eeceipt/data/repositories/order_repository_impl.dart';
import '../../features/order_and_e-eeceipt/domain/repositories/order_repository.dart';
import '../../features/order_and_e-eeceipt/presentation/state/order_state.dart';
import '../../features/order_and_e-eeceipt/presentation/viewmodel/order_viewmodel.dart';
import '../../features/setup_profile_pages/add_new_address/data/datasources/address_local_datasource.dart';
import '../../features/setup_profile_pages/add_new_address/data/repositories/address_repository_impl.dart';
import '../../features/setup_profile_pages/add_new_address/domain/entities/address_entity.dart';
import '../../features/setup_profile_pages/add_new_address/domain/repositories/address_repository.dart';
import '../../features/setup_profile_pages/add_new_address/domain/usecases/save_address_usecase.dart';
import '../../features/setup_profile_pages/add_new_address/presentation/viewmodel/add_new_address_state.dart';
import '../../features/setup_profile_pages/add_new_address/presentation/viewmodel/add_new_address_viewmodel.dart';
import '../../features/setup_profile_pages/pin/presentation/viewmodel/pin_viewmodel.dart';
import '../../features/setup_profile_pages/setup_profile/domain/entities/profile_entity.dart';
import '../../features/setup_profile_pages/setup_profile/domain/usecases/get_profile_usecase.dart';
import '../../features/setup_profile_pages/setup_profile/domain/usecases/save_profile_usecase.dart';
import '../../features/setup_profile_pages/setup_profile/presentation/viewmodel/setup_profile_state.dart';
import '../../features/setup_profile_pages/setup_profile/presentation/viewmodel/setup_profile_viewmodel.dart';
import '../network/api_client.dart';
import '../session/user_session.dart';
import '../storage/local_storage.dart';
import '../storage/token_storage.dart';
import '../../features/setup_profile_pages/setup_profile/data/datasources/profile_local_datasource.dart';
import '../../features/setup_profile_pages/setup_profile/data/datasources/profile_remote_datasource.dart';
import '../../features/setup_profile_pages/setup_profile/data/repositories/profile_repository_impl.dart';
import '../../features/auth/data/datasource/auth_remote_datasource.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';


// ─── SPLASH ───────────────────────────────────────────────────────────────────

final splashRepositoryProvider = Provider<SplashRepositoryImpl>(
      (ref) => SplashRepositoryImpl(),
);

final splashUseCaseProvider = Provider<SplashUseCase>(
      (ref) => SplashUseCase(ref.read(splashRepositoryProvider)),
);

final splashViewModelProvider =
StateNotifierProvider<SplashViewModel, bool>((ref) {
  return SplashViewModel(useCase: ref.read(splashUseCaseProvider));
});

// ─── ONBOARDING ───────────────────────────────────────────────────────────────

final onboardingDataSourceProvider =
Provider<OnboardingLocalDataSource>((ref) {
  return OnboardingLocalDataSourceImpl();
});

final onboardingViewModelProvider =
StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
  return OnboardingViewModel(ref.read(onboardingDataSourceProvider));
});

// ─── WELCOME ──────────────────────────────────────────────────────────────────

final welcomeActionsProvider = Provider<WelcomeActions>((ref) {
  return WelcomeActionsImpl();
});

final welcomeViewModelProvider =
StateNotifierProvider<WelcomeViewModel, WelcomeState>((ref) {
  return WelcomeViewModel(ref.read(welcomeActionsProvider));
});

final createAccountProvider =
StateNotifierProvider.autoDispose<CreateAccountViewModel, CreateAccountState>(
      (ref) => CreateAccountViewModel(ref.read(authRepositoryProvider), ref),
);

// ─── STORAGE ──────────────────────────────────────────────────────────────────

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // overridden in main()
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorageImpl(ref.read(sharedPreferencesProvider));
});

final localStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage(ref.read(sharedPreferencesProvider));
});

// ─── API CLIENT ───────────────────────────────────────────────────────────────

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(tokenStorageProvider));
});

// ─── FORGOT PASSWORD ──────────────────────────────────────────────────────────

final forgotPasswordProvider =
StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordEntity>(
      (ref) => ForgotPasswordViewModel(),
);

final forgotPasswordOtpProvider =
StateNotifierProvider<ForgotPasswordOtpViewModel, ForgotPasswordOtpState>(
      (ref) => ForgotPasswordOtpViewModel(),
);

final newPasswordViewModelProvider =
StateNotifierProvider<NewPasswordViewModel, NewPasswordState>(
      (ref) => NewPasswordViewModel(),
);

final passwordEntityProvider = Provider<PasswordEntity>((ref) {
  return ref.watch(newPasswordViewModelProvider).passwordEntity;
});

// ─── PROFILE ──────────────────────────────────────────────────────────────────

final profileLocalDataSourceProvider =
Provider<ProfileLocalDataSource>((ref) {
  return ProfileLocalDataSource(ref.read(localStorageProvider));
});

final profileRemoteDataSourceProvider =
Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSource(ref.read(apiClientProvider));
});

final profileRepositoryProvider = Provider<ProfileRepositoryImpl>((ref) {
  return ProfileRepositoryImpl(
    ref.read(profileLocalDataSourceProvider),
    ref.read(profileRemoteDataSourceProvider),
  );
});

// ─── AUTH ─────────────────────────────────────────────────────────────────────

final loginAccountViewModelProvider =
StateNotifierProvider<LoginAccountViewModel, LoginAccountModel>(
      (ref) => LoginAccountViewModel(ref.read(authRepositoryProvider), ref),
);

final authRemoteDataSourceProvider =
Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.read(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(tokenStorageProvider),
  );
});

// ─── SETUP PROFILE ────────────────────────────────────────────────────────────

final setupProfileViewModelProvider =
StateNotifierProvider.autoDispose<SetupProfileViewModel, SetupProfileState>(
      (ref) {
    final repo = ref.read(profileRepositoryProvider);
    final storage = ref.read(tokenStorageProvider);
    return SetupProfileViewModel(
      SaveProfileUseCase(repo),
      storage,
      getProfileUseCase: GetProfileUseCase(repo),
    );
  },
);

// ─── ADDRESS ──────────────────────────────────────────────────────────────────

final addNewAddressProvider =
StateNotifierProvider.autoDispose<AddNewAddressViewModel, AddNewAddressState>(
      (ref) {
    final repo = ref.read(addressRepositoryProvider);
    final storage = ref.read(tokenStorageProvider);
    return AddNewAddressViewModel(SaveAddressUseCase(repo), storage, ref);
  },
);

final addressLocalDataSourceProvider =
Provider<AddressLocalDataSource>((ref) {
  return AddressLocalDataSourceImpl(ref.read(localStorageProvider));
});

final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepositoryImpl(ref.read(addressLocalDataSourceProvider));
});

final addressListProvider =
FutureProvider.family<List<AddressEntity>, String>((ref, email) async {
  return ref.read(addressRepositoryProvider).getAddresses(email);
});

final addressProvider = StateProvider<AddressEntity?>((ref) => null);

final emailProvider = FutureProvider<String?>((ref) async {
  return ref.read(tokenStorageProvider).getEmail();
});

final userEmailProvider = FutureProvider<String?>((ref) async {
  return ref.read(tokenStorageProvider).getEmail();
});

// ─── SESSION ──────────────────────────────────────────────────────────────────

final userSessionProvider =
StateNotifierProvider<UserSessionNotifier, String?>((ref) {
  return UserSessionNotifier(ref.read(tokenStorageProvider));
});

final userProfileProvider = FutureProvider<ProfileEntity?>((ref) async {
  final email = ref.watch(userSessionProvider);
  if (email == null) return null;
  return ref.read(profileRepositoryProvider).getProfile(email);
});

final userAddressesProvider =
FutureProvider<List<AddressEntity>>((ref) async {
  final email = ref.watch(userSessionProvider);
  if (email == null) return [];
  return ref.read(addressRepositoryProvider).getAddresses(email);
});

// ─── PIN ──────────────────────────────────────────────────────────────────────

final pinViewModelProvider =
ChangeNotifierProvider.autoDispose<PinViewModel>((ref) {
  return PinViewModel();
});

// ─── PRODUCTS ─────────────────────────────────────────────────────────────────

final productRemoteDataSourceProvider =
Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSource(ref.read(apiClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    ProductRemoteDataSource(ref.read(apiClientProvider)),
    LocalProductDataSource(),
  );
});

final favouriteRemoteDataSourceProvider =
Provider<FavouriteRemoteDataSource>((ref) {
  return FavouriteRemoteDataSource(ref.read(apiClientProvider));
});

final localProductDataSourceProvider =
Provider<LocalProductDataSource>((ref) => LocalProductDataSource());

final homeViewModelProvider =
StateNotifierProvider<HomeViewModel, AsyncValue<List<ProductUiModel>>>(
      (ref) => HomeViewModel(
    ref.read(productRepositoryProvider),
    ref.read(favouriteRemoteDataSourceProvider),
    ref.read(localProductDataSourceProvider),
  ),
);

// ─── CART ─────────────────────────────────────────────────────────────────────

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref.watch(cartRepositoryProvider));
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl(ref.watch(cartRemoteDataSourceProvider));
});

final cartRemoteDataSourceProvider =
Provider<CartRemoteDataSource>((ref) {
  return CartRemoteDataSource(
    ref.watch(apiClientProvider).dio,
    ref.watch(tokenStorageProvider),
  );
});

// ─── ORDER ────────────────────────────────────────────────────────────────────

final orderRemoteDataSourceProvider =
Provider<OrderRemoteDataSource>((ref) {
  return OrderRemoteDataSource(ref.watch(apiClientProvider));
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl(ref.watch(orderRemoteDataSourceProvider));
});

final orderProvider =
StateNotifierProvider<OrderViewModel, OrderState>((ref) {
  return OrderViewModel(ref.watch(orderRepositoryProvider));
});

// ─── AI CHAT ──────────────────────────────────────────────────────────────────

final aiChatRemoteDataSourceProvider =
Provider<AiChatRemoteDataSource>((ref) {
  return AiChatRemoteDataSource(ref.read(apiClientProvider));
});

final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  return AiChatRepositoryImpl(ref.read(aiChatRemoteDataSourceProvider));
});

final aiChatViewModelProvider =
StateNotifierProvider<AiChatViewModel, AiChatState>((ref) {
  return AiChatViewModel(ref.read(aiChatRepositoryProvider));
});