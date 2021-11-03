import 'package:template/data/model/response/language_model.dart';

const String BASE_URL = 'http://103.146.23.186:4009/v1/';
// const String BASE_URL = 'http://192.168.1.11:4009/v1/';

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
enum TYPEFORMAL { CREATE, FEEDBACK }

const String DA_THANH_TOAN = '61604f4cc8e6fa122227e29f';
const String CHUA_THANH_TOAN = '61615180e87a9124404abe82';
// const String DA_PHAN_HOI = '617286ebf5c09a07f815e825';
// const String CHUA_PHAN_HOI = '617286fdf5c09a07f815e826';
// Id loại tài khoản
const String DAI_LY = '6168fb1362f385255f293af2';
const String KHACH_HANG = '6168fb1e62f385255f293afb';
const String THO_THAU = '6168fb3062f385255f293b0b';
const String NHAN_VIEN = '616e71de3535150e7a4d4755';
const String DA_PHAN_HOI = '616ce813cbb2cf21dad90cdf';
const String CHUA_PHAN_HOI = '6170c4bbb3b6a47374f4e677';

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

Map<String, String> quanLyDonHangMap = {
  "Tất cả": "",
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

//Trạng thái thanh toán đơn tuyển dụng

const String TUYEN_DUNG_DA_THANH_TOAN = '61604f4cc8e6fa122227e29f';
const String TUYEN_DUNG_CHUA_THANH_TOAN = '61615180e87a9124404abe82';

//Hình thức thanh toán

const String THANH_TOAN_CHUYEN_KHOAN = '616120008c19c11eb11f862a';
const String THANH_TOAN_KHI_NHAN_HANG = '616cd5d67aade64ebae7c01c';

//Nhóm dịch vụ

const String NHOM_DICH_VU_1 = '616cd0267aade64ebae7bd81';
const String NHOM_DICH_VU_2 = '6168ecdd7cb8ed05dbf3bba5';
const String NHOM_DICH_VU_3 = '61693a7c3391622ae9201fe7';
const String NHOM_DICH_VU_4 = '616049b2c8e6fa122227e283';
const String NHOM_DICH_VU_5 = '616049b6c8e6fa122227e286';
const String NHOM_DICH_VU_6 = '616049bac8e6fa122227e289';
const String NHOM_DICH_VU_7 = '6168f03c7cb8ed05dbf3bcc7';
const String TUYEN_DUNG_TRANG_THAI_TIN_CHUA_DUYET = '6162b79bd3d3e9825095fb20';

//trang thai don hang moi tao
const String TRANG_THAI_DON_HANG_MOI_TAO = '616a39faea30f845b562876d';

//trang thai don hang hoan thanh
const String TRANG_THAI_DON_HANG_HOAN_THANH = '6169a7843391622ae92038ef';

//tình trạng sản phẩm
const dynamic TINH_TRANG_SAN_PHAM = {
  "0": "Mới",
  "1": "Thanh lý",
};

//kiểu vận chuyển
const Map<String, String> KIEU_VAN_CHUYEN = {
  "0": "Không giao đc qua các đơn vị giao hàng (tự vận chuyển)",
  "1": "Giao đc qua các đơn vị giao hàng",
};
