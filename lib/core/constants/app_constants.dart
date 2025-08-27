enum UserType {
  visitors,
  companies,
}

enum InfoType { phone, email, url, text }

enum SearchType {
  companies,
  products,
  partners,
  services,
  news,
  abouts,
}

class AppConstants {
  AppConstants._();

  // Cache keys
  static const String keyToken = "userTokenKey";
  static const String keyVisitorUser = "keyVisitorUser";
  static const String keyEngineerUser = "keyEngineerUser";
  static const String keyUserId = "userIDKey";
  static const String keyUserName = "userNameKey";
  static const String keyUserPassword = "userPasswordKey";
  static const String keyUserEmail = "userEmailKey";
  static const String keyRole = "userRoleKey";
  static const String keyUserPhone = "userPhoneKey";
  static const String keyUserImage = "userImageKey";
  static const String keyIsFirstOpen = "firstOpenKey";
  static const String keyIsAuth = "isAuth";
  static const String keyIsOnBoarded = "isOnBoardedKey";
  // static const String keyIsIphone = "isIphoneKey";
  static const String keyAppLanguage = "langKey";
  static const String keyIsDarkMode = "darkModeKey";
  static const String companiesFilterKey = "companiesFilterKey";
  static const String productsFiltersKey = "productsFiltersKey";
  static const String specificFiltersKey = "specificFiltersKey";
  static const String countriesKey = 'countriesKey';
  static const String socialLinksKey = 'socialLinksKey';
  static const String contactInfoKey = 'contactInfoKey';
  static const String locationInfoKey = 'locationInfoKey';
  static const String generalSettingsKey = 'generalSettingsKey';

  static const String translationsKey = 'translationsKey';
  static const String defaultLanguage = 'ar';




  static const int carouselTime = 3;

  static const int captchaLength = 3;

  static const String captchaChars = '0123456789';



  static const String placeholderImageLink =
      'https://placehold.co/400x400/white/FDA900.png?text=Khan+Alhandaseh&font=cairo';


  // /companies/$companyID
  // /products/$productID
  // /eng_specifications/$specificationID
  //     /news/$newsID
  //    /partners/$partnerID
  //    /engineerings/$engineeringID
  //    /workshops/$workshops/ID
  //    /services/$/services/ID
  //    /abouts/$aboutID
  //    'https://khan-alhandasah.com/${context.locale}/policies',
  //
  //
  //
  //



  static const String _devShareUrl =
      'https://test.khan-alhandasah.com/ar';

  static const String _prodShareUrl =
      'https://khan-alhandasah.com/ar';

  static const shareUrl = _devBaseUrl;


  static const String _devBaseUrl =
      'https://test.khan-alhandasah.com/api';

  static const String _prodBaseUrl =
      'https://khan-alhandasah.com/api';

  static const baseUrl = _devBaseUrl;

}


