import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/home_page/info.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class GroupController extends GetxController {
  UserProvider userProvider = GetIt.I.get<UserProvider>();
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  UserModel userModel = UserModel();
  OrderModel orderModel = OrderModel();
  OrderItemModel orderItemModel = OrderItemModel();

  double? doanhSoDoiNhom;
  double? doanhSoCaNhan;
  int? soLuongId;
  int? soLuongDonGia;
  String? name;
  String? role;

  List<UserInfo> doiNhom = [];

  @override
  void onInit() {
    doanhSoDoiNhom = 0;
    doanhSoCaNhan = 0;
    soLuongId = 0;
    soLuongDonGia = 0;

    name = "";
    role = "";

    getUserById();
    loadDoiNhom();
    super.onInit();
  }

  ///
  /// infoUser
  ///
  void infoUser() {
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        final String userId = value!;
        userProvider.find(
          id: userId,
          onSuccess: (value) {
            userModel = value;
            print(value.toJson());
          },
          onError: (error) {
            print(error);
          },
        );
      },
    );
  }

  ///
  /// lấy thông tin user
  ///
  void getUserById() {
    doanhSoDoiNhom = 0;
    doanhSoCaNhan = 0;
    soLuongId = 0;
    soLuongDonGia = 0;
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        final String userId = value!;
        userProvider.find(
            id: userId,
            onSuccess: (value) {
              name = value.fullname;

              // ??????
              role = value.idOptionalRole;
              update();
            },
            onError: (error) {
              print(error);
            });

        orderProvider.paginate(
          filter: '&idUser=$userId',
          limit: 100,
          page: 1,
          onSuccess: (data) {
            for (final OrderModel element in data) {
              final String orderId = element.id!;
              // order item
              orderItemProvider.paginate(
                page: 1,
                limit: 100,
                filter: "&idOrder=$orderId",
                onSuccess: (models) {
                  for (final OrderItemModel model in models) {
                    if (model.idOrder! == orderId) {
                      soLuongDonGia =
                          soLuongDonGia! + int.parse(model.quantity!);
                      doanhSoCaNhan = doanhSoCaNhan! +
                          int.parse(model.price!) * int.parse(model.quantity!);
                      update();
                    }
                  }
                },
                onError: (error) {
                  print(error);
                },
              );
            }
          },
          onError: (error) {
            print(error);
          },
        );

        userProvider.find(
          id: userId,
          onSuccess: (models) {
            soLuongId = soLuongId! + 1;
            orderProvider.paginate(
              filter: '&idUser=${models.id}',
              limit: 100,
              page: 1,
              onSuccess: (data) {
                for (final OrderModel element in data) {
                  final String orderId = element.id!;
                  // order item
                  orderItemProvider.paginate(
                    page: 1,
                    limit: 100,
                    filter: "&idOrder=$orderId",
                    onSuccess: (models) {
                      for (final OrderItemModel model in models) {
                        if (model.idOrder! == orderId) {
                          doanhSoDoiNhom = doanhSoDoiNhom! +
                              int.parse(model.price!) *
                                  int.parse(model.quantity!);
                          update();
                        }
                      }
                    },
                    onError: (error) {
                      print(error);
                    },
                  );
                }
              },
              onError: (error) {
                print(error);
              },
            );
          },
          onError: (error) {
            print(error);
            // update();
          },
        );
      },
    );
    update();
  }

  ///
  /// load đội nhóm
  ///
  void loadDoiNhom() {
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        final String userId = value!;
        userProvider.paginate(
          filter: '&idUser=${userId}',
          limit: 100,
          page: 1,
          onSuccess: (users) {
            users.forEach((user) {
              UserInfo info =
                  UserInfo(label: user.fullname, money: 0.toString());
              double money = 0;

              orderProvider.paginate(
                filter: '&idUser=${user.id}',
                limit: 100,
                page: 1,
                onSuccess: (List<OrderModel> data) {
                  print("DATAAAAAAAAAA ${user.id} ${data.length}");
                  for (final OrderModel element in data) {
                    final String orderId = element.id!;
                    // order item
                    orderItemProvider.paginate(
                      page: 1,
                      limit: 100,
                      filter: "&idOrder=$orderId",
                      onSuccess: (models) {
                        for (final OrderItemModel model in models) {
                          if (model.idOrder! == orderId) {
                            money = money +
                                int.parse(model.price!) *
                                    int.parse(model.quantity!);
                            doanhSoDoiNhom = doanhSoDoiNhom! +
                                int.parse(model.price!) *
                                    int.parse(model.quantity!);
                            print("OKOKOKOKOKOK $money");
                            update();
                          }
                        }
                      },
                      onError: (error) {
                        print(error);
                      },
                    );
                  }
                },
                onError: (error) {
                  print(error);
                },
              );
              info.money = money.toString();
              update();
              doiNhom.add(info);
              // update();
            });
          },
          onError: (error) {
            print(error);
            // update();
          },
        );
      },
    );
  }
}
