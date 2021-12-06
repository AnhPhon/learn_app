import 'package:template/data/model/response/language_model.dart';

const String BASE_URL = 'http://103.146.23.186:4009/v1/';
// const String BASE_URL = 'http://192.168.1.188:4009/v1/';

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
enum SERVICES { WORK, REGULARLY, VAT_LIEU }
// enum TYPEFORMAL { CREATE, FEEDBACK }

// Id loại tài khoản
const String DAI_LY = '6168fb1362f385255f293af2';
const String KHACH_HANG = '6168fb1e62f385255f293afb';
const String THO_THAU = '6168fb3062f385255f293b0b';
const String NHAN_VIEN = '616e71de3535150e7a4d4755';

// Trạng thái đơn dich vụ
const String DA_PHAN_HOI = '6170c66db3b6a47374f4e678'; //đã báo giá
const String THAT_BAI = '617286fdf5c09a07f815e826';
const String DA_HUY = '61970fcc31c0397701423ae0';
const String CHUA_PHAN_HOI = '616ce813cbb2cf21dad90cdf';
const String TRUNG_THAU = '6170c6b6b3b6a47374f4e67a';
const String DA_DUYET_TIN = '6162b8be062fb4833802ec89';
const String DA_DUYET = '6170c4bbb3b6a47374f4e677';
const String CHUA_NGHIEM_THU = '618a1a10b7ce952de195dd01';
const String DA_NGHIEM_THU = '618a1a54b7ce952de195dd7f';
const String DA_QUYET_TOAN = '618a1a71b7ce952de195ddc2';
const String DA_BAO_GIA = '6170c66db3b6a47374f4e678'; //đã b

const String DON_DICH_VU_CHOT_GIA = '6170c682b3b6a47374f4e679';
const String DON_DICH_VU_DA_BAO_GIA = '6170c66db3b6a47374f4e678';
const String DON_DICH_VU_TRUNG_THAU = '6170c6b6b3b6a47374f4e67a';

// Trạng thái thanh toán
const String THANH_TOAN_UY_QUYEN =
    '61604f4cc8e6fa122227e29f'; // DA_THANH_TOAN : Thanh toán toàn bộ giá trị đơn hàng
const String KHACH_HANG_THANH_TOAN =
    '618232342960f9475ac1437c'; // DAT_COC : Thanh toán đặt cọc 5%
const String CHUA_THANH_TOAN = '61615180e87a9124404abe82';

const String DAT_COT = '618232342960f9475ac1437c';
const String CHOT_GIA = '6170c682b3b6a47374f4e679';
const String DA_THANH_TOAN = '61604f4cc8e6fa122227e29f';
const String DAT_COC_VA_NHAN_VIEC = '618232342960f9475ac1437c';

// Provinder
const String DA_NANG = '618b9e21c7817bd7985ba199';
const String HO_CHI_MINH = '618b9df6c7817bd7985b9a07';
const String HA_NOI = '618b9e05c7817bd7985b9cc5';
// LINK
const String URL_TO_LINK_PDF = '';
const String URL_TO_LINK_EXELS = '';

// LINK ẢNH ĐẠI DIỆN NHÓM DICH VỤ
const String ANH_NHOM_7 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637912642990_una3vSMUhO_Nh%C3%B3m%207.jpg';
const String ANH_NHOM_1 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637912620921_Se07AueItT_Nh%C3%B3m%201%20%281%29.jpg';
const String ANH_NHOM_2 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637911768566_OQ6E0WJuvC_resize-1637911557796596033Nhm2.jpg';
const String ANH_NHOM_3 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637912564435_P2k2hCkegG_resize-163791186761704809Nhm3.jpg';
const String ANH_NHOM_4 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637912515078_PPLUTUEHKh_resize-1637911916268147969Nhm4.jpg';
const String ANH_NHOM_5 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637912497095_9CmyXwexwD_Nh%C3%B3m%205.jpg';
const String ANH_NHOM_6 =
    'https://izisoft.s3.ap-southeast-1.amazonaws.com/p09fivesbs/1637912530411_VvyyXFkQpL_Nh%C3%B3m%206.jpg';
// sharePreference
const String TOKEN = 'token';

List<LanguageModel> languages = [
  LanguageModel(imageUrl: '', languageName: 'Việt Nam', countryCode: 'VI', languageCode: 'vi'),
  LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
];

Map<String, String> trangThaiDonHangMap = {
  "Mới tạo": "6169794b3391622ae920354b",
  "Xác nhận": "616979573391622ae920354d",
  "Chuẩn bị hàng": "6169795f3391622ae920354f",
  "Đang giao": "616979663391622ae9203551",
  "Đã giao": "6169796e3391622ae9203553",
  "Huỷ đơn": "616979743391622ae9203555",
  "Trả hàng": "618a2968d89699350ec68704",
};

Map<String, String> quanLyDonHangMap = {
  "Tất cả": "",
  "Mới tạo": "6169794b3391622ae920354b",
  "Xác nhận": "616979573391622ae920354d",
  "Chuẩn bị hàng": "6169795f3391622ae920354f",
  "Đang giao": "616979663391622ae9203551",
  "Đã giao": "6169796e3391622ae9203553",
  "Huỷ đơn": "616979743391622ae9203555",
  "Trả hàng": "618a2968d89699350ec68704",
};
// sharePreference
const dynamic TRANG_THAI_DU_AN = {
  'CHUA_TRIEN_KHAI': {'tieuDe': 'Chưa triển khai', 'id': '616a7b1d06a577482e02958b'},
  'SAP_TRIEN_KHAI': {'tieuDe': 'Sắp triển khai', 'id': '616a7b4606a577482e02959c'},
  'DANG_TRIEN_KHAI': {'tieuDe': 'Đang triển khai', 'id': '616ce9647aade64ebae7c93f'},
  'DA_TRIEN_KHAI': {'tieuDe': 'Đã triển khai', 'id': '616ce9687aade64ebae7c941'},
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
const String NHOM_DICH_VU_8 = '61853b8ce10f2b16dcdff808';
const String TUYEN_DUNG_TRANG_THAI_TIN_CHUA_DUYET = '6162b79bd3d3e9825095fb20';

//trang thai don hang moi tao
const String TRANG_THAI_DON_HANG_MOI_TAO = '6169794b3391622ae920354b';

//tình trạng sản phẩm
const Map<String, String> TINH_TRANG_SAN_PHAM = {
  "0": "Mới",
  "1": "Thanh lý",
};

//kiểu vận chuyển
const Map<String, String> KIEU_VAN_CHUYEN = {
  "0": "Không giao đc qua các đơn vị giao hàng (tự vận chuyển)",
  "1": "Giao đc qua các đơn vị giao hàng",
};

//kiểu vận chuyển
const Map<String, String> TINH_TRANG_THANH_TOAN_PHAN_HOI = {
  "1": "Đồng ý thanh toán 100%",
  "2": "Đồng ý thanh toán theo thỏa thuận",
  "3": "Chưa đồng ý thanh toán",
};

const String UNDEFINE_LABEL = "Không xác định";
//loại vận chuyển
const Map<String, String> LOAI_VAN_CHUYEN = {
  "1": "Bình thường",
  "2": "Giao gấp",
};

//thời gian làm việc
const Map<String, String> THOI_GIAN_LAM_VIEC = {
  "6166a975caef364c08db415c": "7h30 - 11h30",
  "616e93d2dd0368166d7368b6": "13h30 - 17h30",
  "6166a9a5caef364c08db4162": "18h30 - 22h30",
  "6166a989caef364c08db415e": "11h30 - 17h30",
};

const String TAT_CA_PHUONG_XA = '61a8452c58935e5fc0cfefbc';

const String TAT_CA_QUAN_HUYEN = '61a8451258935e5fc0cfef9c';

//thời gian làm việc
const Map<String, String> TRANG_THAI_DON_DICH_VU_DA_LAM = {
  "618a1a10b7ce952de195dd01": "Chưa nghiệm thu",
  "618a1a54b7ce952de195dd7f": "Đã nghiệm thu",
  "618a1a71b7ce952de195ddc2": "Quyết toán",
};
