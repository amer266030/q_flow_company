import '../model/enums/experience.dart';
import '../model/enums/visitor_status.dart';
import '../model/user/visitor.dart';

List<Visitor> visitors = [
  Visitor(
    id: '111111111',
    fName: 'Alice',
    lName: 'Johnson',
    // status: VisitorStatus.inQueue,
    experience: Experience.oneToFive,
  ),
  Visitor(
    id: '22222222',
    fName: 'Bob',
    lName: 'Smith',
    // status: VisitorStatus.applied,
    experience: Experience.lessThanOne,
  ),
  Visitor(
    id: '3333333',
    fName: 'Charlie',
    lName: 'Brown',
    // status: VisitorStatus.saved,
    experience: Experience.moreThanNine,
  ),
  Visitor(
    id: '44444444',
    fName: 'Diana',
    lName: 'White',
    // status: VisitorStatus.inQueue,
    experience: Experience.fiveToNine,
  ),
  Visitor(
    id: '55555555',
    fName: 'Eve',
    lName: 'Davis',
    // status: VisitorStatus.applied,
    experience: Experience.none,
  ),
  Visitor(
    id: '66666666',
    fName: 'Frank',
    lName: 'Miller',
    // status: VisitorStatus.saved,
    experience: Experience.oneToFive,
  ),
  Visitor(
    id: '7777777',
    fName: 'Grace',
    lName: 'Wilson',
    // status: VisitorStatus.inQueue,
    experience: Experience.lessThanOne,
  ),
  Visitor(
    id: '8888888',
    fName: 'Hank',
    lName: 'Taylor',
    // status: VisitorStatus.applied,
    experience: Experience.fiveToNine,
  ),
];
