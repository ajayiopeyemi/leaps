List<String> subjects = [
  'Integrated science',
  'Civic studies',
  'Health education'
];

List<String> country = [
  'United Kingdom',
  'Malawi',
  'Kenya',
  'Ethiopia',
  'Nigeria',
];


List<String> classInRegion = [];
List<String> planActions = [
  'Un-approve plan',
  'Approve plan',
  'Delete plan',
];

List<String> week = [
  'Select week you want to teach this topic',
  'Week 1',
  'Week 2',
];

class AppString {
  // Titles
  static const String Uhm = 'Uhm!';
  static const String Oops = 'Oops!';
  static const String PasswordResetTitle = 'Password reset';

  // Descriptions
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String NoResultDescription =
      "We have tried all we can,\nthere are no search results. Please try another phrase";
  static const String DeviceOfflineDescription =
      "Looks like your device is not connected, please turn on your data and try again";
  static const String LessonNoteEmptyDescription =
      "Looks like no lesson plan has been created yet, \ncreate a lesson plan now";
  static const String PasswordResetDescription =
      "A link to reset your password will be sent to the email you used while registering \n\nAre you sure you want to reset your password ?";

  static const String VERIFICATION_DESCRIPTION =
      "We've sent your details to an admin who will verify that your are a teacher, once verification is done you will have a new expereince\n\nWhile you wait you can see suggested lesson note other teacher's in your regions as curated";
  static const String RESEARCHER_DESCRIPTION =
      "This account belongs to either and Reseaceher or a CO-I,To use this app as a student or teacher kindly create an account here\n\nYou can logout below to create an account";
  static const String SEARCH_RESULT_ERROR =
      "'An error occured, this may be due to poor internet connection\n\nPlease try again'";

  // Actions
  static const String logout = 'Logout';
  static const String reset = 'Reset';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';

  /*---[Routes}--*/
  static final String subjectCollection = "subjects";
  static final String userCollection = "users";
}

class UserConstants {
  static const String UID = 'uid';
  static const String AVATAR = 'avatar';
  static const String SURNAME = 'surname';
  static const String FIRST_NAME = 'firstname';
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';

  static const String COUNTRY = 'country';
  static const String SCHOOL_NAME = 'school_name';
  static const String CLASS = 'class';

  static const String IS_USER_VERIFIED = 'isUserVerified';
  static const String IS_STUDENT = 'isStudent';

  static String avatarPath(String uId) => 'avatar/$uId';
}

class NotePlanConstants {
  static const String DOC_ID = 'docId';
  static const String OWNER = 'owner';
  static const String SUBJECT = 'subject';
  static const String SUBJECT_INDEX = 'subjectIndex';
  static const String TOPIC = 'topic';
  static const String DURATION = 'duration';
  static const String NO_OF_TEXT_DOCS = 'no_of_text_docs';
  static const String NO_OF_PDF_DOCS = 'no_of_pdf_docs';
  static const String NO_OF_Images = 'no_of_images';
  static const String NO_OF_VIDEOS = 'no_of_videos';
  static const String IS_APPROVED = 'isApproved';

  static const String USER_ID = 'uId';
}

class ResourceConstants {
  static const String NAME = 'name';
  static const String FILE_PATH = 'file_path';
  static const String THUMBNAIL = 'thumbnail';
  static const String SUBJECT = 'subject';
  static const String TOPIC = 'topic';
  static const String HEADING = 'heading';
  static const String DEFINITION = 'definition';
  static const String EXCERPT = 'excerpt';
  static const String TITLE = 'title';
  static const String DURATION = 'duration';
  static const String WEEK = 'week';
  static const String IS_PENDING = 'isPending';
  static const String PATH = 'path';

  static const String COUNTRY = 'country';
  static const String SCHOOLS = 'schools';
  static const String CLASSES = 'classes';

  static const String QUERY = 'query';
}

class RoutePaths {
  static const String MyApp = '/';
  static const String Home = 'home';
  static const String JoinUsNow = 'join_us_now';
  static const String SignIn = 'sign_in';
  static const String SignUp = 'sign_up';
  static const String Explore = 'explore';
  static const String LessonNote = 'lesson_note';
  static const String Account = 'account';
  static const String SearchResult = 'search_result';
}

class ApiConstants {
  static final baseUrl = 'us-central1-leaps-uk.cloudfunctions.net';
  static final apiVersion = 'v1';
  static final rootEndpoint = '/leaps/api/$apiVersion/resources/raw';

  /*---[Routes}--*/
  static final textRoute = 'text';
  static final pdfRoute = 'pdfs';
  static final imagesRoute = 'images';
  static final videosRoute = 'videos';
}

/*---------------*/
///App background colors
/*---------------*/
class AppFont {
  static const String PrimaryFont = 'Montserat';
}

class AppImages {
  static const String PencilAsset = 'assets/images/pencil.jpeg';
  static const String Logo = 'assets/images/logo.png';

  static const String education = 'assets/images/pablo-education.png';
  static const String integrated_science = 'assets/images/integrated_science.png';
  static const String civic_studies = 'assets/images/civic_studies.png';

  /*GIF*/
  static const String NoSearchResult = 'assets/images/no_search_result.gif';
  static const String Verifying = 'assets/images/verifying.gif';
}

class AppSVGs {
  static const String BookLover = 'assets/svgs/book_lover.svg';
  static const String Empty = 'assets/svgs/empty.svg';
  static const String Internet = 'assets/svgs/internet.svg';
  static const String Filter = 'assets/svgs/filter.svg';

  static const String user = 'assets/svgs/user.svg';
  static const String unlocked = 'assets/svgs/unlocked.svg';
  static const String about = 'assets/svgs/about.svg';

  static const String science = 'assets/svgs/science.svg';
  static const String civic = 'assets/svgs/civic.svg';
  static const String health = 'assets/svgs/health.svg';

  static const String camera = 'assets/svgs/camera.svg';
  static const String gallery = 'assets/svgs/gallery.svg';
  static const String play_button = 'assets/svgs/play-button.svg';

  static const String pdf = 'assets/svgs/pdf.svg';

  static const String teacher = 'assets/svgs/teacher.svg';
  static const String student = 'assets/svgs/student.svg';
  static const String forgot_password = 'assets/svgs/forgot_password.svg';
  static const String suggested_teacher = 'assets/svgs/suggested_teacher.svg';

  static const String server_down = 'assets/svgs/server_down.svg';

  ///On Boarding
  static const String digital = 'assets/svgs/digital.svg';
  static const String handpicked_resources = 'assets/svgs/first_page.svg';
  static const String collaboration = 'assets/svgs/collaboration.svg';
  static const String studying = 'assets/svgs/studying.svg';

  static const String university = 'assets/svgs/university.svg';

  static final List<String> subjectsIcons = [
    AppSVGs.science,
    AppSVGs.civic,
    AppSVGs.health
  ];
}
