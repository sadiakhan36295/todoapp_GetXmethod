import 'package:get/get.dart';
import 'package:practice_todoapp/view/model/my_profile.dart';

class MyProfileController extends GetxController {
  Rx<myprofile_model> myProfile = myprofile_model().obs;

  // Use this method to update the full profile model
  void updateProfileData(myprofile_model updatedProfile) {
    myProfile.value = updatedProfile;
    update(); // For GetBuilder or if you want to manually trigger update
  }

  // Helper to get user data easily
  Data? get userData => myProfile.value.data;

  // Optional: Fetch data from server (stubbed example)
  Future<void> fetchProfileData() async {
    // Simulated response - Replace with real API call
    final fakeResponse = {
      "success": true,
      "message": "Profile loaded successfully",
      "data": {
        "_id": "1",
        "name": "Updated Name",
        "email": "updated@example.com",
        "address": "123 Test Street",
        "status": "active",
        "isDeleted": false,
        "createdAt": "2025-01-01T00:00:00Z",
        "updatedAt": "2025-07-25T00:00:00Z",
        "__v": 0,
      }
    };

    myProfile.value = myprofile_model.fromJson(fakeResponse);
    update(); // Notify UI
  }
}
