import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tazkartak_app/src/data/models/ticket_model.dart';
import 'package:tazkartak_app/src/domain/usecase/payment_usecase.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_action.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_state.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/tazkarat_view_model/core/metro_seclection_model.dart';

import '../../../../../core/common/api/api_result.dart';
import '../../../../../core/error_handeler/error_handler.dart';
import '../../../../../core/service/location_manger/location_manger.dart';
import '../../../../../core/service/open_route_servie/open_route_service_api.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  LocationManger locationManger;
  OpenRouteServiceApi openRouteServiceApi;
  PaymentUsecase paymentUsecase;
  HomeCubit(this.locationManger, this.openRouteServiceApi, this.paymentUsecase)
      : super(HomeStateInitialState());

  bool _isPermissionLocationUser = false;
  double metroLatitude = 0;
  double metroLongitude = 0;
  double userLongitude = 0;
  double userLatitude = 0;
  List<LatLng> routesPoint = [];
  String ticketId = "";

  Future<void> doAction({required HomeAction homeAction}) async {
    switch (homeAction) {
      case GetLocationUserDataAction():
        return await _getLocationUserData();
    }
  }

  bool get isPermissionLocationUser => _isPermissionLocationUser;
  List<LatLng> get xroutesPoint => routesPoint;
  Future<void> _getLocationUserData() async {
    try {
      emit(GetLocationUserLoadingState());
      _isPermissionLocationUser =
          await locationManger.canGetLocationPermission();
      if (_isPermissionLocationUser) {
        LocationData locationData = await locationManger.getLocationUser();
        userLatitude = locationData.latitude ?? 0.0;
        userLongitude = locationData.longitude ?? 0.0;
        nearestMetroStation =
            _findNearestMetroStation(userLatitude, userLongitude);
        getNMetroLocation(nearestMetroStation);
        emit(GetLocationUserSuccessState());
        _getRoutes();
      } else {
        emit(GetLocationUserFailuresState(
            errorMassage: "please User Open Location "));
      }
    } catch (e) {
      emit(GetLocationUserFailuresState(errorMassage: e.toString()));
    }
  }

  Future<void> _getRoutes() async {
    emit(GetRoutesLoadingState());
    routesPoint = [];
    var result = await openRouteServiceApi.getRouteMaps(
        startLat: userLatitude,
        startLog: userLongitude,
        endLat: metroLatitude,
        endLog: metroLongitude);
    switch (result) {
      case Success<List<LatLng>>():
        routesPoint = result.data ?? [];
        emit(GetRoutesSuccessState());
      case Failures<List<LatLng>>():
        routesPoint = [];
        emit(GetRoutesFailuresState(errorMassage: result.exception.toString()));
    }
  }

  List<MetroStationModel> metroStations = [
    ...metroStationsOne,
    ...metroStationsTwo,
    ...metroStationsThree,
  ];

  String nearestMetroStation = "من فضلك افتج location ";

  String _findNearestMetroStation(double userLat, double userLng) {
    double minDistance = double.infinity;
    String closestStation = "غير معروف";

    for (var station in metroStations) {
      double distance = _calculateDistance(
        userLat,
        userLng,
        station.latitude,
        station.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        closestStation = station.name;
      }
    }
    return closestStation;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // نصف قطر الأرض بالكيلومترات
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void getNMetroLocation(String? text) {
    if (text == null || text == "من فضلك افتج location ") {
      return;
    }
    for (var element in metroStations) {
      if (element.name == text) {
        metroLatitude = element.latitude;
        metroLongitude = element.longitude;
        return;
      }
    }
  }

  Future<void> openStripePaymentSheet() async {
    try {
      // Trigger the payment sheet (this shows the Stripe UI)
      await paymentUsecase.executePayment("5000", "EGP");
      // If successful, emit a success state
      emit(PaymentSuccessState());
      debugPrint('Payment completed successfully.');
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled ||
          e.error.localizedMessage!.toLowerCase().contains('cancel')) {
        // Emit a cancellation state if the user cancels the payment
        emit(CancelPaymentState());
        debugPrint('Payment sheet closed by user. No navigation.');
      } else {
        // Handle other errors appropriately
        debugPrint('Stripe error: ${e.error.localizedMessage}');
      }
    }
  }

  Future<void> storeTicket(TicketModel ticket) async {
    try {
      emit(SaveTiketLoadingState());
      print('ticket: ${ticket.toJson()}');
      var result = await paymentUsecase.executeStoreTicket(ticket);
      switch (result) {
        case Success<String>():
          ticketId = result.data!;
          emit(SaveTiketSuccessState());

        case Failures<String>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(SaveTiketFailuresState(errorMassage: errorMessage));
      }
    } catch (e) {
      emit(SaveTiketFailuresState(errorMassage: e.toString()));
    }
  }
}
