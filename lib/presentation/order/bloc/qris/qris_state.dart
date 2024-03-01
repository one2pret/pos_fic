part of 'qris_bloc.dart';

@freezed
class QrisState with _$QrisState {
  const factory QrisState.initial() = _Initial;
  const factory QrisState.loading() = _Loading;
  //succes 
  const factory QrisState.success(String message) = _Success;
  //qrisResponseModel 
  const factory QrisState.qrisResponseModel(QrisResponseModel qrisResponseModel) = _QrisResponseModel;
  //failure
  const factory QrisState.error(String message) = _Error; 
  //status check 
  const factory QrisState.statusCheck(QrisStatusResponseModel qrisStatusResponseModel) = _StatusCheck;



}
