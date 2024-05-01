import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import '../../../core/models/model.dart';
import '../../../core/providers/global_provider.dart';
import '../../../core/repositories/api_repository.dart';

class RemoteProvider extends ChangeNotifier {
  final GlobalProvider? globalProvider;
  final ApiRepository? apiRepository;

  RemoteProvider(
      {required GlobalProvider this.globalProvider,
      required ApiRepository this.apiRepository});

  // final jitsiMeet = JitsiMeet();
  bool _isGettingRemote = false;

  bool get isGettingRemote => _isGettingRemote;

  final TextEditingController _remoteIdController = TextEditingController();

  TextEditingController get remoteIdController => _remoteIdController;

  @override
  void dispose() {
    remoteIdController.dispose();
    super.dispose();
  }

  void validateConnection() {
    _isGettingRemote = true;
    notifyListeners();
    String connectionId = remoteIdController.text;
    String serialNumber = globalProvider!.deviceInfo!.serialNumber!;
    try {
      apiRepository!
          .validateConnection(connectionId, serialNumber)
          .then((response) {
        if (response['status'] == "success") {
          RemoteConnection connection =
              RemoteConnection.fromJson(response['data']['remote']);
          //   join(connection);
          _isGettingRemote = false;
          notifyListeners();
        } else {
          _handleValidateConnectionError(response);
        }
      });
    } catch (e) {
      print(e);
      _handleValidateConnectionError({"message": "An exception occurred"});
    }
  }

  _handleValidateConnectionError(Map<String, dynamic> response) {
    globalProvider!.handleError(response, notify: true);
    _isGettingRemote = false;
    notifyListeners();
  }

  // void join(RemoteConnection connection) async {
  //   var options = JitsiMeetConferenceOptions(
  //     serverURL: "https://meet.jit.si",
  //     room: "${connection.connectionId}",
  //     configOverrides: {
  //       "startWithAudioMuted": true,
  //       "startWithVideoMuted": true,
  //       "subject": "Remote Support",
  //       "localSubject": "Remote Support",
  //     },
  //     featureFlags: {
  //       FeatureFlags.androidScreenSharingEnabled: true,
  //       FeatureFlags.unsafeRoomWarningEnabled: false,
  //       FeatureFlags.addPeopleEnabled: false,
  //       FeatureFlags.welcomePageEnabled: false,
  //       FeatureFlags.preJoinPageEnabled: false,
  //       FeatureFlags.resolution: FeatureFlagVideoResolutions.resolution720p,
  //       FeatureFlags.audioFocusDisabled: false,
  //       FeatureFlags.audioMuteButtonEnabled: false,
  //       FeatureFlags.audioOnlyButtonEnabled: false,
  //       FeatureFlags.calenderEnabled: false,
  //       FeatureFlags.callIntegrationEnabled: false,
  //       FeatureFlags.carModeEnabled: false,
  //       FeatureFlags.closeCaptionsEnabled: false,
  //       FeatureFlags.conferenceTimerEnabled: false,
  //       FeatureFlags.chatEnabled: false,
  //       FeatureFlags.filmstripEnabled: false,
  //       FeatureFlags.fullScreenEnabled: true,
  //       FeatureFlags.helpButtonEnabled: false,
  //       FeatureFlags.inviteEnabled: false,
  //       FeatureFlags.speakerStatsEnabled: false,
  //       FeatureFlags.kickOutEnabled: false,
  //       FeatureFlags.liveStreamingEnabled: false,
  //       FeatureFlags.lobbyModeEnabled: false,
  //       FeatureFlags.meetingNameEnabled: false,
  //       FeatureFlags.meetingPasswordEnabled: false,
  //       FeatureFlags.notificationEnabled: false,
  //       FeatureFlags.overflowMenuEnabled: true,
  //       FeatureFlags.pipEnabled: false,
  //       FeatureFlags.pipWhileScreenSharingEnabled: false,
  //       FeatureFlags.preJoinPageHideDisplayName: false,
  //       FeatureFlags.raiseHandEnabled: false,
  //       FeatureFlags.reactionsEnabled: false,
  //       FeatureFlags.recordingEnabled: false,
  //       FeatureFlags.replaceParticipant: false,
  //       FeatureFlags.securityOptionEnabled: false,
  //       FeatureFlags.serverUrlChangeEnabled: false,
  //       FeatureFlags.settingsEnabled: false,
  //       FeatureFlags.tileViewEnabled: false,
  //       FeatureFlags.videoMuteEnabled: false,
  //       FeatureFlags.videoShareEnabled: false,
  //       FeatureFlags.toolboxEnabled: true,
  //       FeatureFlags.iosRecordingEnabled: false,
  //       FeatureFlags.iosScreenSharingEnabled: false,
  //       FeatureFlags.toolboxAlwaysVisible: true,
  //     },
  //     userInfo:
  //         JitsiMeetUserInfo(displayName: connection.terminal!.serialNumber),
  //     // userInfo: JitsiMeetUserInfo(displayName: "Test Account"),
  //   );
  //   await jitsiMeet.join(options);
  //   await jitsiMeet.toggleScreenShare(true);
  // }
}
