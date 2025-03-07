import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialog.dart';

void checkForUpdateAndShowDialog(BuildContext context) async {
  final isAndroid = Platform.isAndroid;
  final url = isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.samy.azkar2&hl=en-US'
      : 'https://www.apple.com/app-store/';

  if (isAndroid) {
    final shouldUpdate = await checkForUpdate();
    if (shouldUpdate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        UpdateDialog.show(
          context,
          title: 'تحديث جديد متوفر',
          message:
              'هناك إصدار جديد من التطبيق متوفر. قم بالتحديث للحصول على أحدث الميزات والتحسينات.',
          onUpdate: () {
            launchUrl(Uri.parse(url));
          },
          onLater: () {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
        );
      });
    }
  }
}

Future<bool> checkForUpdate() async {
  try {
    if (await _isPlayStoreInstall()) {
      print('checkForUpdate:t:if');
      // Use in_app_update for Play Store installs
      final updateInfo = await InAppUpdate.checkForUpdate();
      print('updateInfo.updateAvailability: ${updateInfo.updateAvailability}');
      print(
          'UpdateAvailability.updateAvailable: ${UpdateAvailability.updateAvailable}');
      return updateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable;
    } else {
      print('checkForUpdate:t:else');
      // Fallback to web scraping for development/testing
      return await _checkPlayStoreWebpage();
    }
  } catch (e) {
    print('checkForUpdate:c');
    print('Error checking for updates: $e');
    return false;
  }
}

Future<bool> _isPlayStoreInstall() async {
  try {
    final updateInfo = await InAppUpdate.checkForUpdate();
    return true;
  } catch (e) {
    if (e is PlatformException && e.code == 'TASK_FAILURE') {
      return false; // Not installed from Play Store
    }
    rethrow;
  }
}

Future<bool> _checkPlayStoreWebpage() async {
  print('_checkPlayStoreWebpage');
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final response = await http.get(
      Uri.parse(
          'https://play.google.com/store/apps/details?id=${packageInfo.packageName}'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
      },
    );

    if (response.statusCode == 200) {
      // Updated patterns that match current Play Store structure
      final patterns = [
        RegExp(r'\[\[\["([\d.]+)"\]\]'),  // New Play Store format
        RegExp(r'\"version\":\s*\"([\d.]+)\"'),  // JSON format
        RegExp(r'Version\s*([\d.]+)'), // Simple version format
        RegExp(r'version=([\d.]+)'),  // URL parameter format
      ];


      for (final pattern in patterns) {
        final match = pattern.firstMatch(response.body);
        print('match: $match');
        if (match != null) {
          final latestVersion = match.group(1)!.trim();
          print('Found version: $latestVersion');
          print('packageInfo.buildNumber: ${packageInfo.buildNumber}');
          return currentVersion != latestVersion;
        }
      }

      print('No version pattern matched in Play Store page');
    } else {
      print('Failed to fetch Play Store page: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in web scraping fallback: $e');
  }

  return false; // Default to no update if we can't determine version
}
