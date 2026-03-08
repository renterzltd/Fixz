import 'package:fixz/hdHelper/exportFile.dart';

class RequstRepairModel extends BaseModel {
  Repository _repository;

  RequstRepairModel(this._repository);

  Future<ApiResponse> addRepairJob(
      String details,
      String repaingTime,
      String reparingDate,
      String hourEstimate,
      String categoryID,
      String subCategoryId,
      String description) async {
    ApiResponse response = await _repository.addRepairJob(
        "",
        details,
        "",
        DateTime.now().millisecondsSinceEpoch,
        0,
        0,
        AppConstant.REQUEST_REPAIR,
        repaingTime,
        reparingDate,
        hourEstimate,
        description,
        categoryID,
        subCategoryId,
        0);

    return response;
  }
}
