import 'package:flutter/material.dart';

class UIStrings {
  static String loginTitle = "Log in to your account";
  static String signupTitle = "Create your account";
  static String addUserTitle = "Add a new user";
  static String signupSubTitle = "Join our community and get started";
  static String newOnApp = "New to Our App?";
  static String haveAccount = "Already have an account?";

  static String emailHint = "Enter your email";
  static String usernameHint = "Enter your username";
  static String passwordHint = "Enter your password";
  static String fnameHint = "John";
  static String lnameHint = "Type here...";
  static String typehereHint = "Type here...";
  static String ageHint = "Enter your age";
  static String emailformatHint = "you@example.com";
  static String passwordformatHint = "Enter a Strong Password";
  static String emailLabel = "Email";
  static String passwordLabel = "Password";
  static String fname = "First Name";
  static String lname = "Last Name";
  static String age = "Age";
  static String gender = "Gender";
  static String username = "Username";
  static String birthDate = "Birth Date";
  static String phoneLabel = "Phone Number";
  static String country = "Country";
  static String searchbarHint = "Search by name or email...";

  static String loginButton = "Login";
  static String signupButton = "Create Account";
  static String editBtn = "Edit";
  static String addUserBtn = "Add User";

  static String editprofileButton = "Save Changes";
  static String forgotPassword = "Forgot Password?";

  static String appbarUserDetails = "User Details";
  static String appbarEditProfile = "Edit Profile";
  static String appbarUsers = "Users";
  static String appbarSettings = "Settings";
  static String tileProfile = "Profile";
  static String settingsGeneral = "GENERAL";
  static String settingsAccount = "ACCOUNT";
  static String tileTheme = "Theme";
  static String tileLogout = "Logout";
  static String tileDelete = "Delete Account";

  static String loginFailed = "Login failed. Please check your credentials";
}

class UIColours {
  static Color primaryColor = const Color(0xFF4a90e2);
  static Color grey = const Color(0xB3727272);
  static Color black = const Color.fromARGB(255, 0, 0, 0);
  static Color white = Colors.white;
  static Color greyShade = Colors.grey.shade600;
  static Color errorColor = Colors.red;
  static Color successColor = Colors.green;
  static Color transparent = Colors.transparent;
  static Color blackShade = const Color.fromARGB(255, 22, 22, 22);
}

class UISizes {
  static double titleFontSize = 24.0;
  static double subtitleFontSize = 16.0;
  static double btnFontSize = 18.0;
  static double labelFontSize = 14.0;
  static double inputFontSize = 16.0;
  static double mainSpacing = 20.0;
  static double midSpacing = 18.0;
  static double subSpacing = 10.0;
  static double minSpacing = 5.0;
  static double inputRadius = 10.0;
  static double aroundPadding = 20.0;
  static double verticalInputPadding = 15.0;
  static double horizontalInputPadding = 18.0;
  static double appbarHeight = 56.0;
  static double tileTitle = 17.0;
  static double tileSubtitle = 14.0;
  static double trailIconSize = 16.0;
  static double btnHeight = 45.0;
}

class UIIcons {
  static Icon logoIcon = const Icon(Icons.settings, size: 50);
  static Icon emailIcon = const Icon(Icons.email_outlined);
  static Icon passwordIcon = const Icon(Icons.lock_outline);
  static Icon passwordEyeIcon = Icon(
    Icons.visibility_outlined,
    color: Colors.grey,
  );
  static Icon passwordEyeDisabledIcon = Icon(
    Icons.visibility_off_outlined,
    color: Colors.grey,
  );
  static Icon settingsIcon = const Icon(Icons.settings_outlined);
  static Icon arrowBtnIcon = Icon(
    Icons.arrow_forward_ios_outlined,
    size: UISizes.trailIconSize,
  );
  static Icon dltBtnIcon = Icon(Icons.delete_outlined, color: Colors.red);

  static Icon addIcon = Icon(Icons.add_outlined, color: Colors.white, size: 17);
  static Icon editIcon = Icon(
    Icons.edit_outlined,
    color: Colors.white,
    size: 17,
  );

  static Icon favorite = Icon(Icons.favorite_border, color: Colors.red);
  static Icon favoriteFilled = Icon(Icons.favorite, color: Colors.red);

  static Icon filter = Icon(Icons.sort_by_alpha_rounded, size: 25);

  static Icon tileThemeIcon = Icon(Icons.brightness_6_outlined);
  static Icon fnameIcon = const Icon(Icons.person);
  static Icon logout = const Icon(Icons.logout);
  static Icon bottomappbarUser = const Icon(Icons.group_outlined);
  static Icon lnameIcon = const Icon(Icons.person);
  static Icon ageIcon = const Icon(Icons.cake);
  static Icon genderIcon = const Icon(Icons.wc);
}

class AssetsPath {
  static String profile = "assets/images/profile.png";
}

class sharedPrefKeys {
  static String userDataKey = "user";
  static String accessTokenKey = "accessToken";
  static String refreshTokenKey = "refreshToken";
}
