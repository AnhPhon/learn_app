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

// Enum
enum SERVICES { WORK, REGULARLY }

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

Map<String, String> trangThaiDonHangMap = {
  "Xác nhận": "6169794b3391622ae920354b",
  "Chuẩn bị hàng": "616979573391622ae920354d",
  "Đang giao": "6169795f3391622ae920354f",
  "Đã giao": "616979663391622ae9203551",
  "Huỷ đơn": "6169796e3391622ae9203553",
  "Trả hàng": "616979743391622ae9203555",
};
// sharePreference
const dynamic TRANG_THAI_DU_AN = {
  'CHUA_TRIEN_KHAI': {
    'tieuDe': 'Chưa triển khai',
    'id': '616a7b1d06a577482e02958b'
  },
  'SAP_TRIEN_KHAI': {
    'tieuDe': 'Sắp triển khai',
    'id': '616a7b4606a577482e02959c'
  },
  'DANG_TRIEN_KHAI': {
    'tieuDe': 'Đang triển khai',
    'id': '616ce9647aade64ebae7c93f'
  },
  'DA_TRIEN_KHAI': {
    'tieuDe': 'Đã triển khai',
    'id': '616ce9687aade64ebae7c941'
  },
};
