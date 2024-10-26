enum TechSkill {
  mobileDevelopment,
  webDevelopment,
  cybersecurity,
  cloudComputing,
  dataScience,
  devOps,
  databaseManagement,
  uiUxDesign,
  blockchainDevelopment,
  networking,
  softwareTesting,
  embeddedSystems,
  projectManagement,
  artificialIntelligence,
  gameDevelopment,
  itSupport,
  bigData,
  enterpriseResourcePlanning,
  arVrDevelopment,
  robotics,
  systemArchitecture,
  businessIntelligence,
  eCommerceDevelopment,
  digitalMarketing,
  automation,
  virtualization,
  aiMlOps,
  technicalWriting,
  softwareEngineering
}

extension TechSkillExtension on TechSkill {
  String get value {
    switch (this) {
      case TechSkill.mobileDevelopment:
        return 'Mobile Development';
      case TechSkill.webDevelopment:
        return 'Web Development';
      case TechSkill.cybersecurity:
        return 'Cybersecurity';
      case TechSkill.cloudComputing:
        return 'Cloud Computing';
      case TechSkill.dataScience:
        return 'Data Science';
      case TechSkill.devOps:
        return 'DevOps';
      case TechSkill.databaseManagement:
        return 'Database Management';
      case TechSkill.uiUxDesign:
        return 'UI/UX Design';
      case TechSkill.blockchainDevelopment:
        return 'Blockchain Development';
      case TechSkill.networking:
        return 'Networking';
      case TechSkill.softwareTesting:
        return 'Software Testing';
      case TechSkill.embeddedSystems:
        return 'Embedded Systems';
      case TechSkill.projectManagement:
        return 'Project Management';
      case TechSkill.artificialIntelligence:
        return 'Artificial Intelligence';
      case TechSkill.gameDevelopment:
        return 'Game Development';
      case TechSkill.itSupport:
        return 'IT Support';
      case TechSkill.bigData:
        return 'Big Data';
      case TechSkill.enterpriseResourcePlanning:
        return 'Enterprise Resource Planning';
      case TechSkill.arVrDevelopment:
        return 'AR/VR Development';
      case TechSkill.robotics:
        return 'Robotics';
      case TechSkill.systemArchitecture:
        return 'System Architecture';
      case TechSkill.businessIntelligence:
        return 'Business Intelligence';
      case TechSkill.eCommerceDevelopment:
        return 'E-commerce Development';
      case TechSkill.digitalMarketing:
        return 'Digital Marketing';
      case TechSkill.automation:
        return 'Automation';
      case TechSkill.virtualization:
        return 'Virtualization';
      case TechSkill.aiMlOps:
        return 'AI/ML Ops';
      case TechSkill.technicalWriting:
        return 'Technical Writing';
      case TechSkill.softwareEngineering:
        return 'Software Engineering';
      default:
        return '';
    }
  }

  static TechSkill fromString(String? skill) {
    switch (skill) {
      case 'Mobile Development':
        return TechSkill.mobileDevelopment;
      case 'Web Development':
        return TechSkill.webDevelopment;
      case 'Cybersecurity':
        return TechSkill.cybersecurity;
      case 'Cloud Computing':
        return TechSkill.cloudComputing;
      case 'Data Science':
        return TechSkill.dataScience;
      case 'DevOps':
        return TechSkill.devOps;
      case 'Database Management':
        return TechSkill.databaseManagement;
      case 'UI/UX Design':
        return TechSkill.uiUxDesign;
      case 'Blockchain Development':
        return TechSkill.blockchainDevelopment;
      case 'Networking':
        return TechSkill.networking;
      case 'Software Testing':
        return TechSkill.softwareTesting;
      case 'Embedded Systems':
        return TechSkill.embeddedSystems;
      case 'Project Management':
        return TechSkill.projectManagement;
      case 'Artificial Intelligence':
        return TechSkill.artificialIntelligence;
      case 'Game Development':
        return TechSkill.gameDevelopment;
      case 'IT Support':
        return TechSkill.itSupport;
      case 'Big Data':
        return TechSkill.bigData;
      case 'Enterprise Resource Planning':
        return TechSkill.enterpriseResourcePlanning;
      case 'AR/VR Development':
        return TechSkill.arVrDevelopment;
      case 'Robotics':
        return TechSkill.robotics;
      case 'System Architecture':
        return TechSkill.systemArchitecture;
      case 'Business Intelligence':
        return TechSkill.businessIntelligence;
      case 'E-commerce Development':
        return TechSkill.eCommerceDevelopment;
      case 'Digital Marketing':
        return TechSkill.digitalMarketing;
      case 'Automation':
        return TechSkill.automation;
      case 'Virtualization':
        return TechSkill.virtualization;
      case 'AI/ML Ops':
        return TechSkill.aiMlOps;
      case 'Technical Writing':
        return TechSkill.technicalWriting;
      case 'Software Engineering':
        return TechSkill.softwareEngineering;
      default:
        throw ArgumentError('Invalid skill value');
    }
  }
}
