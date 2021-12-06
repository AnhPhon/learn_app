import 'package:template/data/model/response/language_model.dart';

const String BASE_URL = 'http://103.146.23.186:4009/v1/';

// Enum
enum SERVICES { WORK, REGULARLY, VAT_LIEU }

List<LanguageModel> languages = [
  LanguageModel(imageUrl: '', languageName: 'Việt Nam', countryCode: 'VI', languageCode: 'vi'),
  LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
];
