
import '../domain/onboarding_page_model.dart';

abstract class OnboardingLocalDataSource {
  List<OnboardingPageModel> getPages();
}

class OnboardingLocalDataSourceImpl
    implements OnboardingLocalDataSource {
  @override
  List<OnboardingPageModel> getPages() {
    return [
      OnboardingPageModel(
        imagePath: 'assets/images/onboarding_image1.png',
        title: 'Welcome to Plantify: Your Digital\nOasis for Plant Lovers!',
        description:
        'Welcome to Plantify, your ultimate destination for all things plant-related. Get ready to embark on an exciting journey into the world of lush greenery and discover the joy of nurturing your own plants.',
      ),
      OnboardingPageModel(
        imagePath: 'assets/images/onboarding_image3.png',
        title: 'Unlock the World of Plants with\nOur App!',
        description:
        'Dive into a virtual garden brimming with a wide variety of plants. Swipe through our curated collection, from vibrant flowers to elegant succulents, and everything in between.',
      ),
      OnboardingPageModel(
        imagePath: 'assets/images/onboarding_image3.png',
        title: 'Seamless Shopping Experience',
        description:
        'With our user-friendly interface and secure payment options, shopping for your favorite plants has never been easier. Add plants to your cart, explore related products, and enjoy a hassle-free checkout process.\nYour plant companions will be on their way to you in no time.',
      ),
    ];
  }
}
