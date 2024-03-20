import 'dart:async';
import '../src/connection.dart';
import 'dom.dart' as dom;
import 'network.dart' as network;
import 'page.dart' as page;

/// This domain emulates different environments for the page.
class EmulationApi {
  final Client _client;

  EmulationApi(this._client);

  /// Notification sent after the virtual time budget for the current VirtualTimePolicy has run out.
  Stream<void> get onVirtualTimeBudgetExpired => _client.onEvent
      .where((event) => event.name == 'Emulation.virtualTimeBudgetExpired');

  /// Tells whether emulation is supported.
  /// Returns: True if emulation is supported.
  Future<bool> canEmulate() async {
    var result = await _client.send('Emulation.canEmulate');
    return result['result'] as bool;
  }

  /// Clears the overridden device metrics.
  Future<void> clearDeviceMetricsOverride() async {
    await _client.send('Emulation.clearDeviceMetricsOverride');
  }

  /// Clears the overridden Geolocation Position and Error.
  Future<void> clearGeolocationOverride() async {
    await _client.send('Emulation.clearGeolocationOverride');
  }

  /// Requests that page scale factor is reset to initial values.
  Future<void> resetPageScaleFactor() async {
    await _client.send('Emulation.resetPageScaleFactor');
  }

  /// Enables or disables simulating a focused and active page.
  /// [enabled] Whether to enable to disable focus emulation.
  Future<void> setFocusEmulationEnabled(bool enabled) async {
    await _client.send('Emulation.setFocusEmulationEnabled', {
      'enabled': enabled,
    });
  }

  /// Automatically render all web contents using a dark theme.
  /// [enabled] Whether to enable or disable automatic dark mode.
  /// If not specified, any existing override will be cleared.
  Future<void> setAutoDarkModeOverride({bool? enabled}) async {
    await _client.send('Emulation.setAutoDarkModeOverride', {
      if (enabled != null) 'enabled': enabled,
    });
  }

  /// Enables CPU throttling to emulate slow CPUs.
  /// [rate] Throttling rate as a slowdown factor (1 is no throttle, 2 is 2x slowdown, etc).
  Future<void> setCPUThrottlingRate(num rate) async {
    await _client.send('Emulation.setCPUThrottlingRate', {
      'rate': rate,
    });
  }

  /// Sets or clears an override of the default background color of the frame. This override is used
  /// if the content does not specify one.
  /// [color] RGBA of the default background color. If not specified, any existing override will be
  /// cleared.
  Future<void> setDefaultBackgroundColorOverride({dom.RGBA? color}) async {
    await _client.send('Emulation.setDefaultBackgroundColorOverride', {
      if (color != null) 'color': color,
    });
  }

  /// Overrides the values of device screen dimensions (window.screen.width, window.screen.height,
  /// window.innerWidth, window.innerHeight, and "device-width"/"device-height"-related CSS media
  /// query results).
  /// [width] Overriding width value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  /// [height] Overriding height value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  /// [deviceScaleFactor] Overriding device scale factor value. 0 disables the override.
  /// [mobile] Whether to emulate mobile device. This includes viewport meta tag, overlay scrollbars, text
  /// autosizing and more.
  /// [scale] Scale to apply to resulting view image.
  /// [screenWidth] Overriding screen width value in pixels (minimum 0, maximum 10000000).
  /// [screenHeight] Overriding screen height value in pixels (minimum 0, maximum 10000000).
  /// [positionX] Overriding view X position on screen in pixels (minimum 0, maximum 10000000).
  /// [positionY] Overriding view Y position on screen in pixels (minimum 0, maximum 10000000).
  /// [dontSetVisibleSize] Do not set visible view size, rely upon explicit setVisibleSize call.
  /// [screenOrientation] Screen orientation override.
  /// [viewport] If set, the visible area of the page will be overridden to this viewport. This viewport
  /// change is not observed by the page, e.g. viewport-relative elements do not change positions.
  /// [displayFeature] If set, the display feature of a multi-segment screen. If not set, multi-segment support
  /// is turned-off.
  /// [devicePosture] If set, the posture of a foldable device. If not set the posture is set
  /// to continuous.
  Future<void> setDeviceMetricsOverride(
      int width, int height, num deviceScaleFactor, bool mobile,
      {num? scale,
      int? screenWidth,
      int? screenHeight,
      int? positionX,
      int? positionY,
      bool? dontSetVisibleSize,
      ScreenOrientation? screenOrientation,
      page.Viewport? viewport,
      DisplayFeature? displayFeature,
      DevicePosture? devicePosture}) async {
    await _client.send('Emulation.setDeviceMetricsOverride', {
      'width': width,
      'height': height,
      'deviceScaleFactor': deviceScaleFactor,
      'mobile': mobile,
      if (scale != null) 'scale': scale,
      if (screenWidth != null) 'screenWidth': screenWidth,
      if (screenHeight != null) 'screenHeight': screenHeight,
      if (positionX != null) 'positionX': positionX,
      if (positionY != null) 'positionY': positionY,
      if (dontSetVisibleSize != null) 'dontSetVisibleSize': dontSetVisibleSize,
      if (screenOrientation != null) 'screenOrientation': screenOrientation,
      if (viewport != null) 'viewport': viewport,
      if (displayFeature != null) 'displayFeature': displayFeature,
      if (devicePosture != null) 'devicePosture': devicePosture,
    });
  }

  /// [hidden] Whether scrollbars should be always hidden.
  Future<void> setScrollbarsHidden(bool hidden) async {
    await _client.send('Emulation.setScrollbarsHidden', {
      'hidden': hidden,
    });
  }

  /// [disabled] Whether document.coookie API should be disabled.
  Future<void> setDocumentCookieDisabled(bool disabled) async {
    await _client.send('Emulation.setDocumentCookieDisabled', {
      'disabled': disabled,
    });
  }

  /// [enabled] Whether touch emulation based on mouse input should be enabled.
  /// [configuration] Touch/gesture events configuration. Default: current platform.
  Future<void> setEmitTouchEventsForMouse(bool enabled,
      {@Enum(['mobile', 'desktop']) String? configuration}) async {
    assert(configuration == null ||
        const ['mobile', 'desktop'].contains(configuration));
    await _client.send('Emulation.setEmitTouchEventsForMouse', {
      'enabled': enabled,
      if (configuration != null) 'configuration': configuration,
    });
  }

  /// Emulates the given media type or media feature for CSS media queries.
  /// [media] Media type to emulate. Empty string disables the override.
  /// [features] Media features to emulate.
  Future<void> setEmulatedMedia(
      {String? media, List<MediaFeature>? features}) async {
    await _client.send('Emulation.setEmulatedMedia', {
      if (media != null) 'media': media,
      if (features != null) 'features': [...features],
    });
  }

  /// Emulates the given vision deficiency.
  /// [type] Vision deficiency to emulate. Order: best-effort emulations come first, followed by any
  /// physiologically accurate emulations for medically recognized color vision deficiencies.
  Future<void> setEmulatedVisionDeficiency(
      @Enum([
        'none',
        'blurredVision',
        'reducedContrast',
        'achromatopsia',
        'deuteranopia',
        'protanopia',
        'tritanopia'
      ])
      String type) async {
    assert(const [
      'none',
      'blurredVision',
      'reducedContrast',
      'achromatopsia',
      'deuteranopia',
      'protanopia',
      'tritanopia'
    ].contains(type));
    await _client.send('Emulation.setEmulatedVisionDeficiency', {
      'type': type,
    });
  }

  /// Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  /// unavailable.
  /// [latitude] Mock latitude
  /// [longitude] Mock longitude
  /// [accuracy] Mock accuracy
  Future<void> setGeolocationOverride(
      {num? latitude, num? longitude, num? accuracy}) async {
    await _client.send('Emulation.setGeolocationOverride', {
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
    });
  }

  Future<num> getOverriddenSensorInformation(SensorType type) async {
    var result =
        await _client.send('Emulation.getOverriddenSensorInformation', {
      'type': type,
    });
    return result['requestedSamplingFrequency'] as num;
  }

  /// Overrides a platform sensor of a given type. If |enabled| is true, calls to
  /// Sensor.start() will use a virtual sensor as backend rather than fetching
  /// data from a real hardware sensor. Otherwise, existing virtual
  /// sensor-backend Sensor objects will fire an error event and new calls to
  /// Sensor.start() will attempt to use a real sensor instead.
  Future<void> setSensorOverrideEnabled(bool enabled, SensorType type,
      {SensorMetadata? metadata}) async {
    await _client.send('Emulation.setSensorOverrideEnabled', {
      'enabled': enabled,
      'type': type,
      if (metadata != null) 'metadata': metadata,
    });
  }

  /// Updates the sensor readings reported by a sensor type previously overridden
  /// by setSensorOverrideEnabled.
  Future<void> setSensorOverrideReadings(
      SensorType type, SensorReading reading) async {
    await _client.send('Emulation.setSensorOverrideReadings', {
      'type': type,
      'reading': reading,
    });
  }

  /// Overrides the Idle state.
  /// [isUserActive] Mock isUserActive
  /// [isScreenUnlocked] Mock isScreenUnlocked
  Future<void> setIdleOverride(bool isUserActive, bool isScreenUnlocked) async {
    await _client.send('Emulation.setIdleOverride', {
      'isUserActive': isUserActive,
      'isScreenUnlocked': isScreenUnlocked,
    });
  }

  /// Clears Idle state overrides.
  Future<void> clearIdleOverride() async {
    await _client.send('Emulation.clearIdleOverride');
  }

  /// Overrides value returned by the javascript navigator object.
  /// [platform] The platform navigator.platform should return.
  @Deprecated('This command is deprecated')
  Future<void> setNavigatorOverrides(String platform) async {
    await _client.send('Emulation.setNavigatorOverrides', {
      'platform': platform,
    });
  }

  /// Sets a specified page scale factor.
  /// [pageScaleFactor] Page scale factor.
  Future<void> setPageScaleFactor(num pageScaleFactor) async {
    await _client.send('Emulation.setPageScaleFactor', {
      'pageScaleFactor': pageScaleFactor,
    });
  }

  /// Switches script execution in the page.
  /// [value] Whether script execution should be disabled in the page.
  Future<void> setScriptExecutionDisabled(bool value) async {
    await _client.send('Emulation.setScriptExecutionDisabled', {
      'value': value,
    });
  }

  /// Enables touch on platforms which do not support them.
  /// [enabled] Whether the touch event emulation should be enabled.
  /// [maxTouchPoints] Maximum touch points supported. Defaults to one.
  Future<void> setTouchEmulationEnabled(bool enabled,
      {int? maxTouchPoints}) async {
    await _client.send('Emulation.setTouchEmulationEnabled', {
      'enabled': enabled,
      if (maxTouchPoints != null) 'maxTouchPoints': maxTouchPoints,
    });
  }

  /// Turns on virtual time for all frames (replacing real-time with a synthetic time source) and sets
  /// the current virtual time policy.  Note this supersedes any previous time budget.
  /// [budget] If set, after this many virtual milliseconds have elapsed virtual time will be paused and a
  /// virtualTimeBudgetExpired event is sent.
  /// [maxVirtualTimeTaskStarvationCount] If set this specifies the maximum number of tasks that can be run before virtual is forced
  /// forwards to prevent deadlock.
  /// [initialVirtualTime] If set, base::Time::Now will be overridden to initially return this value.
  /// Returns: Absolute timestamp at which virtual time was first enabled (up time in milliseconds).
  Future<num> setVirtualTimePolicy(VirtualTimePolicy policy,
      {num? budget,
      int? maxVirtualTimeTaskStarvationCount,
      network.TimeSinceEpoch? initialVirtualTime}) async {
    var result = await _client.send('Emulation.setVirtualTimePolicy', {
      'policy': policy,
      if (budget != null) 'budget': budget,
      if (maxVirtualTimeTaskStarvationCount != null)
        'maxVirtualTimeTaskStarvationCount': maxVirtualTimeTaskStarvationCount,
      if (initialVirtualTime != null) 'initialVirtualTime': initialVirtualTime,
    });
    return result['virtualTimeTicksBase'] as num;
  }

  /// Overrides default host system locale with the specified one.
  /// [locale] ICU style C locale (e.g. "en_US"). If not specified or empty, disables the override and
  /// restores default host system locale.
  Future<void> setLocaleOverride({String? locale}) async {
    await _client.send('Emulation.setLocaleOverride', {
      if (locale != null) 'locale': locale,
    });
  }

  /// Overrides default host system timezone with the specified one.
  /// [timezoneId] The timezone identifier. List of supported timezones:
  /// https://source.chromium.org/chromium/chromium/deps/icu.git/+/faee8bc70570192d82d2978a71e2a615788597d1:source/data/misc/metaZones.txt
  /// If empty, disables the override and restores default host system timezone.
  Future<void> setTimezoneOverride(String timezoneId) async {
    await _client.send('Emulation.setTimezoneOverride', {
      'timezoneId': timezoneId,
    });
  }

  /// Resizes the frame/viewport of the page. Note that this does not affect the frame's container
  /// (e.g. browser window). Can be used to produce screenshots of the specified size. Not supported
  /// on Android.
  /// [width] Frame width (DIP).
  /// [height] Frame height (DIP).
  @Deprecated('This command is deprecated')
  Future<void> setVisibleSize(int width, int height) async {
    await _client.send('Emulation.setVisibleSize', {
      'width': width,
      'height': height,
    });
  }

  /// [imageTypes] Image types to disable.
  Future<void> setDisabledImageTypes(List<DisabledImageType> imageTypes) async {
    await _client.send('Emulation.setDisabledImageTypes', {
      'imageTypes': [...imageTypes],
    });
  }

  /// [hardwareConcurrency] Hardware concurrency to report
  Future<void> setHardwareConcurrencyOverride(int hardwareConcurrency) async {
    await _client.send('Emulation.setHardwareConcurrencyOverride', {
      'hardwareConcurrency': hardwareConcurrency,
    });
  }

  /// Allows overriding user agent with the given string.
  /// `userAgentMetadata` must be set for Client Hint headers to be sent.
  /// [userAgent] User agent to use.
  /// [acceptLanguage] Browser language to emulate.
  /// [platform] The platform navigator.platform should return.
  /// [userAgentMetadata] To be sent in Sec-CH-UA-* headers and returned in navigator.userAgentData
  Future<void> setUserAgentOverride(String userAgent,
      {String? acceptLanguage,
      String? platform,
      UserAgentMetadata? userAgentMetadata}) async {
    await _client.send('Emulation.setUserAgentOverride', {
      'userAgent': userAgent,
      if (acceptLanguage != null) 'acceptLanguage': acceptLanguage,
      if (platform != null) 'platform': platform,
      if (userAgentMetadata != null) 'userAgentMetadata': userAgentMetadata,
    });
  }

  /// Allows overriding the automation flag.
  /// [enabled] Whether the override should be enabled.
  Future<void> setAutomationOverride(bool enabled) async {
    await _client.send('Emulation.setAutomationOverride', {
      'enabled': enabled,
    });
  }
}

/// Screen orientation.
class ScreenOrientation {
  /// Orientation type.
  final ScreenOrientationType type;

  /// Orientation angle.
  final int angle;

  ScreenOrientation({required this.type, required this.angle});

  factory ScreenOrientation.fromJson(Map<String, dynamic> json) {
    return ScreenOrientation(
      type: ScreenOrientationType.fromJson(json['type'] as String),
      angle: json['angle'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'angle': angle,
    };
  }
}

enum ScreenOrientationType {
  portraitPrimary('portraitPrimary'),
  portraitSecondary('portraitSecondary'),
  landscapePrimary('landscapePrimary'),
  landscapeSecondary('landscapeSecondary'),
  ;

  final String value;

  const ScreenOrientationType(this.value);

  factory ScreenOrientationType.fromJson(String value) =>
      ScreenOrientationType.values.firstWhere((e) => e.value == value);

  String toJson() => value;

  @override
  String toString() => value.toString();
}

class DisplayFeature {
  /// Orientation of a display feature in relation to screen
  final DisplayFeatureOrientation orientation;

  /// The offset from the screen origin in either the x (for vertical
  /// orientation) or y (for horizontal orientation) direction.
  final int offset;

  /// A display feature may mask content such that it is not physically
  /// displayed - this length along with the offset describes this area.
  /// A display feature that only splits content will have a 0 mask_length.
  final int maskLength;

  DisplayFeature(
      {required this.orientation,
      required this.offset,
      required this.maskLength});

  factory DisplayFeature.fromJson(Map<String, dynamic> json) {
    return DisplayFeature(
      orientation:
          DisplayFeatureOrientation.fromJson(json['orientation'] as String),
      offset: json['offset'] as int,
      maskLength: json['maskLength'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orientation': orientation,
      'offset': offset,
      'maskLength': maskLength,
    };
  }
}

enum DisplayFeatureOrientation {
  vertical('vertical'),
  horizontal('horizontal'),
  ;

  final String value;

  const DisplayFeatureOrientation(this.value);

  factory DisplayFeatureOrientation.fromJson(String value) =>
      DisplayFeatureOrientation.values.firstWhere((e) => e.value == value);

  String toJson() => value;

  @override
  String toString() => value.toString();
}

class DevicePosture {
  /// Current posture of the device
  final DevicePostureType type;

  DevicePosture({required this.type});

  factory DevicePosture.fromJson(Map<String, dynamic> json) {
    return DevicePosture(
      type: DevicePostureType.fromJson(json['type'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}

enum DevicePostureType {
  continuous('continuous'),
  folded('folded'),
  ;

  final String value;

  const DevicePostureType(this.value);

  factory DevicePostureType.fromJson(String value) =>
      DevicePostureType.values.firstWhere((e) => e.value == value);

  String toJson() => value;

  @override
  String toString() => value.toString();
}

class MediaFeature {
  final String name;

  final String value;

  MediaFeature({required this.name, required this.value});

  factory MediaFeature.fromJson(Map<String, dynamic> json) {
    return MediaFeature(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

/// advance: If the scheduler runs out of immediate work, the virtual time base may fast forward to
/// allow the next delayed task (if any) to run; pause: The virtual time base may not advance;
/// pauseIfNetworkFetchesPending: The virtual time base may not advance if there are any pending
/// resource fetches.
enum VirtualTimePolicy {
  advance('advance'),
  pause('pause'),
  pauseIfNetworkFetchesPending('pauseIfNetworkFetchesPending'),
  ;

  final String value;

  const VirtualTimePolicy(this.value);

  factory VirtualTimePolicy.fromJson(String value) =>
      VirtualTimePolicy.values.firstWhere((e) => e.value == value);

  String toJson() => value;

  @override
  String toString() => value.toString();
}

/// Used to specify User Agent Client Hints to emulate. See https://wicg.github.io/ua-client-hints
class UserAgentBrandVersion {
  final String brand;

  final String version;

  UserAgentBrandVersion({required this.brand, required this.version});

  factory UserAgentBrandVersion.fromJson(Map<String, dynamic> json) {
    return UserAgentBrandVersion(
      brand: json['brand'] as String,
      version: json['version'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'version': version,
    };
  }
}

/// Used to specify User Agent Client Hints to emulate. See https://wicg.github.io/ua-client-hints
/// Missing optional values will be filled in by the target with what it would normally use.
class UserAgentMetadata {
  /// Brands appearing in Sec-CH-UA.
  final List<UserAgentBrandVersion>? brands;

  /// Brands appearing in Sec-CH-UA-Full-Version-List.
  final List<UserAgentBrandVersion>? fullVersionList;

  final String platform;

  final String platformVersion;

  final String architecture;

  final String model;

  final bool mobile;

  final String? bitness;

  final bool? wow64;

  UserAgentMetadata(
      {this.brands,
      this.fullVersionList,
      required this.platform,
      required this.platformVersion,
      required this.architecture,
      required this.model,
      required this.mobile,
      this.bitness,
      this.wow64});

  factory UserAgentMetadata.fromJson(Map<String, dynamic> json) {
    return UserAgentMetadata(
      brands: json.containsKey('brands')
          ? (json['brands'] as List)
              .map((e) =>
                  UserAgentBrandVersion.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      fullVersionList: json.containsKey('fullVersionList')
          ? (json['fullVersionList'] as List)
              .map((e) =>
                  UserAgentBrandVersion.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      platform: json['platform'] as String,
      platformVersion: json['platformVersion'] as String,
      architecture: json['architecture'] as String,
      model: json['model'] as String,
      mobile: json['mobile'] as bool? ?? false,
      bitness: json.containsKey('bitness') ? json['bitness'] as String : null,
      wow64: json.containsKey('wow64') ? json['wow64'] as bool : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'platformVersion': platformVersion,
      'architecture': architecture,
      'model': model,
      'mobile': mobile,
      if (brands != null) 'brands': brands!.map((e) => e.toJson()).toList(),
      if (fullVersionList != null)
        'fullVersionList': fullVersionList!.map((e) => e.toJson()).toList(),
      if (bitness != null) 'bitness': bitness,
      if (wow64 != null) 'wow64': wow64,
    };
  }
}

/// Used to specify sensor types to emulate.
/// See https://w3c.github.io/sensors/#automation for more information.
enum SensorType {
  absoluteOrientation('absolute-orientation'),
  accelerometer('accelerometer'),
  ambientLight('ambient-light'),
  gravity('gravity'),
  gyroscope('gyroscope'),
  linearAcceleration('linear-acceleration'),
  magnetometer('magnetometer'),
  proximity('proximity'),
  relativeOrientation('relative-orientation'),
  ;

  final String value;

  const SensorType(this.value);

  factory SensorType.fromJson(String value) =>
      SensorType.values.firstWhere((e) => e.value == value);

  String toJson() => value;

  @override
  String toString() => value.toString();
}

class SensorMetadata {
  final bool? available;

  final num? minimumFrequency;

  final num? maximumFrequency;

  SensorMetadata(
      {this.available, this.minimumFrequency, this.maximumFrequency});

  factory SensorMetadata.fromJson(Map<String, dynamic> json) {
    return SensorMetadata(
      available:
          json.containsKey('available') ? json['available'] as bool : null,
      minimumFrequency: json.containsKey('minimumFrequency')
          ? json['minimumFrequency'] as num
          : null,
      maximumFrequency: json.containsKey('maximumFrequency')
          ? json['maximumFrequency'] as num
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (available != null) 'available': available,
      if (minimumFrequency != null) 'minimumFrequency': minimumFrequency,
      if (maximumFrequency != null) 'maximumFrequency': maximumFrequency,
    };
  }
}

class SensorReadingSingle {
  final num value;

  SensorReadingSingle({required this.value});

  factory SensorReadingSingle.fromJson(Map<String, dynamic> json) {
    return SensorReadingSingle(
      value: json['value'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

class SensorReadingXYZ {
  final num x;

  final num y;

  final num z;

  SensorReadingXYZ({required this.x, required this.y, required this.z});

  factory SensorReadingXYZ.fromJson(Map<String, dynamic> json) {
    return SensorReadingXYZ(
      x: json['x'] as num,
      y: json['y'] as num,
      z: json['z'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }
}

class SensorReadingQuaternion {
  final num x;

  final num y;

  final num z;

  final num w;

  SensorReadingQuaternion(
      {required this.x, required this.y, required this.z, required this.w});

  factory SensorReadingQuaternion.fromJson(Map<String, dynamic> json) {
    return SensorReadingQuaternion(
      x: json['x'] as num,
      y: json['y'] as num,
      z: json['z'] as num,
      w: json['w'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'z': z,
      'w': w,
    };
  }
}

class SensorReading {
  final SensorReadingSingle? single;

  final SensorReadingXYZ? xyz;

  final SensorReadingQuaternion? quaternion;

  SensorReading({this.single, this.xyz, this.quaternion});

  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      single: json.containsKey('single')
          ? SensorReadingSingle.fromJson(json['single'] as Map<String, dynamic>)
          : null,
      xyz: json.containsKey('xyz')
          ? SensorReadingXYZ.fromJson(json['xyz'] as Map<String, dynamic>)
          : null,
      quaternion: json.containsKey('quaternion')
          ? SensorReadingQuaternion.fromJson(
              json['quaternion'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (single != null) 'single': single!.toJson(),
      if (xyz != null) 'xyz': xyz!.toJson(),
      if (quaternion != null) 'quaternion': quaternion!.toJson(),
    };
  }
}

/// Enum of image types that can be disabled.
enum DisabledImageType {
  avif('avif'),
  webp('webp'),
  ;

  final String value;

  const DisabledImageType(this.value);

  factory DisabledImageType.fromJson(String value) =>
      DisabledImageType.values.firstWhere((e) => e.value == value);

  String toJson() => value;

  @override
  String toString() => value.toString();
}
