abstract class AppStates {}

class AppInitState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppSuccessState extends AppStates {}

class AppErrorState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class ProfileImageErrorState extends AppStates {}

class ProfileImageSuccessState extends AppStates {}

class CoverImageErrorState extends AppStates {}

class CoverImageSuccessState extends AppStates {}

class UpdateProfileLoading extends AppStates {}

class UpdateProfileSuccess extends AppStates {}

class UpdateProfileError extends AppStates {}

class PostImagePickedSuccess extends AppStates {}

class PostImagePickedError extends AppStates {}

class RemovePostImageFromPreviewState extends AppStates {}

class GetPostCollectionSuccess extends AppStates {}

class GetPostCollectionError extends AppStates {}

class CreatNewPostSuccess extends AppStates {}

class CreatNewPostError extends AppStates {}

class GetPostDataSuccess extends AppStates {}

class GetPostDataError extends AppStates {}

class GetApiDataLoading extends AppStates {}

class GetApiDataSuccess extends AppStates {}

class GetApiDataError extends AppStates {}

class GetAllUsersLoading extends AppStates {}

class GetAllUsersSuccess extends AppStates {}

class GetAllUsersError extends AppStates {}

class SendMassageSuccess extends AppStates {}

class SendMassageSError extends AppStates {}

class GetMassageSuccess extends AppStates {}

class GetMassageError extends AppStates {}
