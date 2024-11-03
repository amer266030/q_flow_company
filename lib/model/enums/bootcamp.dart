enum Bootcamp {
  grc,
  uiUx,
  ai,
  socL1,
  aspDotNet,
  flutter,
  js,
  java,
  unity,
  penTest,
  swift,
  aws,
  dataScience,
  springBoot;
}

extension BootcampExtension on Bootcamp {
  String get value {
    switch (this) {
      case Bootcamp.grc:
        return 'GRC';
      case Bootcamp.uiUx:
        return 'UI/UX';
      case Bootcamp.ai:
        return 'AI';
      case Bootcamp.socL1:
        return 'SOC L1';
      case Bootcamp.aspDotNet:
        return 'ASP.NET';
      case Bootcamp.flutter:
        return 'Flutter';
      case Bootcamp.js:
        return 'JavaScript';
      case Bootcamp.java:
        return 'Java';
      case Bootcamp.unity:
        return 'Unity';
      case Bootcamp.penTest:
        return 'Penetration Testing';
      case Bootcamp.swift:
        return 'Swift';
      case Bootcamp.aws:
        return 'AWS';
      case Bootcamp.dataScience:
        return 'Data Science';
      case Bootcamp.springBoot:
        return 'Spring Boot';
      default:
        return '';
    }
  }

  static Bootcamp fromString(String? bootcamp) {
    switch (bootcamp) {
      case 'GRC':
        return Bootcamp.grc;
      case 'UI/UX':
        return Bootcamp.uiUx;
      case 'AI':
        return Bootcamp.ai;
      case 'SOC L1':
        return Bootcamp.socL1;
      case 'ASP.NET':
        return Bootcamp.aspDotNet;
      case 'Flutter':
        return Bootcamp.flutter;
      case 'JavaScript':
        return Bootcamp.js;
      case 'Java':
        return Bootcamp.java;
      case 'Unity':
        return Bootcamp.unity;
      case 'Penetration Testing':
        return Bootcamp.penTest;
      case 'Swift':
        return Bootcamp.swift;
      case 'AWS':
        return Bootcamp.aws;
      case 'Data Science':
        return Bootcamp.dataScience;
      case 'Spring Boot':
        return Bootcamp.springBoot;
      default:
        throw ArgumentError('Invalid bootcamp value');
    }
  }
}
