import 'package:flutter/material.dart';
import 'package:weatherapp_flutter/extension/time_of_day_extension.dart';
import 'package:weatherapp_flutter/presentation/component/alert/normal_arlert_dialog.dart';
import 'package:weatherapp_flutter/presentation/component/alert/setting_transition_alert_dialog.dart';
import 'package:weatherapp_flutter/service/notification_service.dart';

class NotificationButton extends StatefulWidget {
  NotificationButton({
    super.key,
  }) : notificationService = NotificationService();

  final NotificationService notificationService;

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  bool isSetNotification = false;
  void _setNotificationStatus() async {
    final isSet = await widget.notificationService.checkPendingNotifications();
    setState(() {
      isSetNotification = isSet;
    });
  }

  void resisterNotification() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext ddcontext, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      final isResister = await widget.notificationService
          .scheduleDailyNotification(time: time.toTZDateTime());
      if (!context.mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final timeStirng = time.toJapaneseString();
        final message = isResister ? "毎日$timeStirngに通知します" : "登録失敗しました";
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NormalAlertDialog(title: "通知の登録", message: message);
          },
        );
      });
    }
    _setNotificationStatus();
  }

  void removeNotification() async {
    await widget.notificationService.cancelAllNotifications();
    if (!context.mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NormalAlertDialog(
              title: "通知の解除", message: "通知の登録を解除しました");
        },
      );
    });
    _setNotificationStatus();
  }

  @override
  void initState() {
    _setNotificationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isSetNotification
          ? const Icon(Icons.notifications)
          : const Icon(Icons.notifications_off_outlined),
      onPressed: () async {
        final isActiveNotification =
            await widget.notificationService.checkNotificationPermissions();
        if (isActiveNotification) {
          if (isSetNotification) {
            removeNotification();
          } else {
            resisterNotification();
          }
        } else {
          if (!context.mounted) return;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SettingTransitionAlertDialog(
                  title: "通知が許可されていません",
                  message: "設定から通知を許可してください",
                );
              },
            );
          });
        }
      },
    );
  }
}
