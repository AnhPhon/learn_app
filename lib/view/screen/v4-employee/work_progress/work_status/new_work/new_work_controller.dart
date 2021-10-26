import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4NewWorkController extends GetxController {
  GetIt sl = GetIt.instance;
  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  CongViecNhanVienResponse? moiTaoModel;

  //Khai báo isLoading
  bool isLoading = true;

  String? selectIndex;
  String? keyIndex;
  List<CongViecNhanVienResponse> selectList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //Get chi tiết thông tin chi tiết công việc MỚI TẠO
    getDetailNewWork();

    //Load Trạng thái
    loadTrangThai();
  }

  ///
  ///Get thông tin chi tiết công việc mới tạo
  ///
  void getDetailNewWork() {
    //get chi tiết công việc mới tạo theo id
    sl.get<SharedPreferenceHelper>().idNewWork.then((id) {
      congViecNhanVienProvider.find(
        id: id!,
        onSuccess: (value) {
          moiTaoModel = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// load trang thai
  ///
  void loadTrangThai() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: 1,
        limit: 30,
        filter: "&idNhanVien=$id",
        onSuccess: (models) {
          selectList = [];
          for (final element in models) {
            final String trangThai = element.trangThai!.toLowerCase();
            if (trangThai == '1' ||
                trangThai == '2' ||
                trangThai == '3' ||
                trangThai == '4') {
              selectList.add(element);
            }
          }
          if (selectList.isNotEmpty) {
            selectIndex = selectList[0].trangThai;
            keyIndex = selectList[0].id;
          }
          print(selectList);
          print(keyIndex);
          print(selectIndex);
          isLoading = false;

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// on status change
  ///
  void onStatusChange(String? name, String? id) {
    selectIndex = name;
    keyIndex = id;
    update();
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  /// Tính tiến độ công việc
  ///
  int tienDo({required String startDate, required String endDate}) {
    return DateConverter.differenceDateyyyyMMdd(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
