import 'package:template/data/model/response/language_model.dart';

const String BASE_URL = 'http://103.146.23.186:4009/v1/';

// api url
const String region_uri = 'v1/regions';

//login
const String login_uri = 'auth/login';

// TOPIC Firebase
const String TOPIC = 'TOPIC';

const double BOTTOMSHEET = 150;

const String LANG_KEY = 'lang';
const String COUNTRY_CODE = 'country_code';
const String LANGUAGE_CODE = 'language_code';
const String THEME = 'theme';

// sharePreference
const String TOKEN = 'token';

List<LanguageModel> languages = [
  LanguageModel(
      imageUrl: '',
      languageName: 'Việt Nam',
      countryCode: 'VI',
      languageCode: 'vi'),
  LanguageModel(
      imageUrl: '',
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en'),
];
