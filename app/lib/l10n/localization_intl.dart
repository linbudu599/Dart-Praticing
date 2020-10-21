import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

/**
 * 必须要翻译title和remainingEmailsMessage字段，description是该字段的说明，通常给翻译人员看，代码中不会用到。
  有两点需要说明：
  如果某个特定的arb中缺失某个属性，那么应用将会加载默认的arb文件(intl_messages.arb)中的相应属性，这是Intl的托底策略。
  每次运行提取命令时，intl_messages.arb都会根据代码重新生成，但其他arb文件不会，所以当要添加新的字段或方法时，其他arb文件是增量的，不用担心会覆盖。
  arb文件是标准的，其格式规范可以自行了解。通常会将arb文件交给翻译人员，当他们完成翻译后，我们再通过下面的步骤根据arb文件生成最终的dart代码。
 */

// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart ../l10n-arb/intl_*.arb

class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new DemoLocalizations();
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  // Intl.plural方法可以在howMany值不同时输出不同的提示信息。
  remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});
}

//Locale代理类
class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    //3
    return DemoLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
