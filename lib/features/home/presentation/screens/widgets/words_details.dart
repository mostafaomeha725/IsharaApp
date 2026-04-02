String _asBulletText(List<String> lines) {
  return lines.map((line) => '- $line').join('\n');
}

final Map<String, Map<String, String>> lessonsData = {
  'A': {
    'title': 'A',
    'steps': _asBulletText([
      'Make a fist',
      'Keep your thumb resting along the side of your fingers',
      'Keep palm facing forward',
    ]),
    'mistakes': _asBulletText([
      'Hiding the thumb inside the fingers',
      'Opening the fingers instead of closing them',
      'Turning the palm inward',
    ]),
  },
  'B': {
    'title': 'B',
    'steps': _asBulletText([
      'Hold all four fingers straight and together',
      'Press your thumb across your palm',
      'Keep palm facing forward',
    ]),
    'mistakes': _asBulletText([
      'Letting fingers separate',
      'Thumb sticking out',
      'Bending the fingers',
    ]),
  },
  'C': {
    'title': 'C',
    'steps': _asBulletText([
      'Curve your hand into a C shape',
      'Keep fingers and thumb rounded',
      'Maintain a natural gap',
    ]),
    'mistakes': _asBulletText([
      'Closing too much (looks like O)',
      'Opening too wide',
      'Keeping fingers straight',
    ]),
  },
  'D': {
    'title': 'D',
    'steps': _asBulletText([
      'Raise your index finger straight up',
      'Form a circle with thumb and other fingers',
      'Keep palm forward',
    ]),
    'mistakes': _asBulletText([
      'Raising more than one finger',
      'Not forming a clear circle',
      'Bent index finger',
    ]),
  },
  'E': {
    'title': 'E',
    'steps': _asBulletText([
      'Bend all fingers down',
      'Touch fingertips to thumb',
      'Keep hand relaxed',
    ]),
    'mistakes': _asBulletText([
      'Clenching too tight',
      'Not touching thumb',
      'Fingers too spread',
    ]),
  },
  'F': {
    'title': 'F',
    'steps': _asBulletText([
      'Touch thumb and index finger to form a circle',
      'Extend remaining fingers upward',
      'Keep hand steady',
    ]),
    'mistakes': _asBulletText([
      'Circle not closed',
      'Other fingers bent',
      'Hand tilted',
    ]),
  },
  'G': {
    'title': 'G',
    'steps': _asBulletText([
      'Point index finger sideways',
      'Thumb parallel to index',
      'Other fingers closed',
    ]),
    'mistakes': _asBulletText([
      'Pointing upward instead of sideways',
      'Thumb too far',
      'Fingers open',
    ]),
  },
  'H': {
    'title': 'H',
    'steps': _asBulletText([
      'Extend index and middle fingers together sideways',
      'Keep them parallel',
      'Other fingers closed',
    ]),
    'mistakes': _asBulletText([
      'Separating fingers',
      'Pointing upward',
      'Extra fingers open',
    ]),
  },
  'I': {
    'title': 'I',
    'steps': _asBulletText([
      'Make a fist',
      'Extend pinky finger upward',
      'Keep palm forward',
    ]),
    'mistakes': _asBulletText([
      'Other fingers not closed',
      'Pinky bent',
      'Thumb misplaced',
    ]),
  },
  'J': {
    'title': 'J',
    'steps': _asBulletText([
      'Start with I handshape',
      'Draw a J in the air with pinky',
      'Keep motion smooth',
    ]),
    'mistakes': _asBulletText([
      'No movement',
      'Wrong direction',
      'Using whole hand instead of pinky',
    ]),
  },
  'K': {
    'title': 'K',
    'steps': _asBulletText([
      'Raise index and middle fingers',
      'Place thumb between them',
      'Keep palm forward',
    ]),
    'mistakes': _asBulletText([
      'Fingers too close',
      'Thumb outside',
      'Incorrect angle',
    ]),
  },
  'L': {
    'title': 'L',
    'steps': _asBulletText([
      'Extend thumb and index to form L shape',
      'Keep other fingers closed',
      'Palm facing outward',
    ]),
    'mistakes': _asBulletText([
      'Bent index finger',
      'Thumb not extended',
      'Extra fingers open',
    ]),
  },
  'M': {
    'title': 'M',
    'steps': _asBulletText([
      'Place thumb under three fingers',
      'Keep fingers over thumb',
      'Hand closed',
    ]),
    'mistakes': _asBulletText([
      'Thumb visible',
      'Wrong number of fingers',
      'Loose hand',
    ]),
  },
  'N': {
    'title': 'N',
    'steps': _asBulletText([
      'Place thumb under two fingers',
      'Keep fingers resting on thumb',
      'Hand closed',
    ]),
    'mistakes': _asBulletText([
      'Using three fingers (M)',
      'Thumb showing',
      'Fingers not aligned',
    ]),
  },
  'O': {
    'title': 'O',
    'steps': _asBulletText([
      'Touch all fingertips to thumb',
      'Form a round shape',
      'Keep hand relaxed',
    ]),
    'mistakes': _asBulletText([
      'Too tight',
      'Shape not round',
      'Fingers separated',
    ]),
  },
  'P': {
    'title': 'P',
    'steps': _asBulletText([
      'Form K shape',
      'Tilt hand downward',
      'Keep fingers steady',
    ]),
    'mistakes': _asBulletText([
      'Not tilting down',
      'Wrong finger position',
      'Confusing with K',
    ]),
  },
  'Q': {
    'title': 'Q',
    'steps': _asBulletText([
      'Point index and thumb downward',
      'Keep them parallel',
      'Other fingers closed',
    ]),
    'mistakes': _asBulletText([
      'Pointing forward',
      'Thumb misaligned',
      'Fingers open',
    ]),
  },
  'R': {
    'title': 'R',
    'steps': _asBulletText([
      'Cross index and middle fingers',
      'Keep other fingers closed',
      'Palm forward',
    ]),
    'mistakes': _asBulletText([
      'Not crossing',
      'Extra fingers open',
      'Loose shape',
    ]),
  },
  'S': {
    'title': 'S',
    'steps': _asBulletText([
      'Make a fist',
      'Place thumb across front of fingers',
      'Keep tight shape',
    ]),
    'mistakes': _asBulletText([
      'Thumb on side (A)',
      'Loose fist',
      'Fingers visible',
    ]),
  },
  'T': {
    'title': 'T',
    'steps': _asBulletText([
      'Place thumb between index and middle fingers',
      'Close hand',
      'Keep fingers tight',
    ]),
    'mistakes': _asBulletText([
      'Thumb too deep',
      'Thumb outside',
      'Loose grip',
    ]),
  },
  'U': {
    'title': 'U',
    'steps': _asBulletText([
      'Extend index and middle fingers together',
      'Keep them straight',
      'Other fingers closed',
    ]),
    'mistakes': _asBulletText([
      'Fingers separated (V)',
      'Bent fingers',
      'Extra fingers open',
    ]),
  },
  'V': {
    'title': 'V',
    'steps': _asBulletText([
      'Extend index and middle fingers apart',
      'Form a V shape',
      'Other fingers closed',
    ]),
    'mistakes': _asBulletText([
      'Fingers too close',
      'Bent shape',
      'Extra fingers open',
    ]),
  },
  'W': {
    'title': 'W',
    'steps': _asBulletText([
      'Extend three fingers',
      'Spread them apart',
      'Thumb and pinky closed',
    ]),
    'mistakes': _asBulletText([
      'Only two fingers',
      'Fingers too close',
      'Extra fingers open',
    ]),
  },
  'X': {
    'title': 'X',
    'steps': _asBulletText([
      'Curl index finger like a hook',
      'Close other fingers',
      'Keep thumb tucked',
    ]),
    'mistakes': _asBulletText([
      'Straight index finger',
      'Loose hand',
      'Thumb visible',
    ]),
  },
  'Y': {
    'title': 'Y',
    'steps': _asBulletText([
      'Extend thumb and pinky',
      'Close other fingers',
      'Keep hand steady',
    ]),
    'mistakes': _asBulletText([
      'Other fingers open',
      'Thumb not extended',
      'Weak shape',
    ]),
  },
  'Z': {
    'title': 'Z',
    'steps': _asBulletText([
      'Use index finger',
      'Draw Z shape in air',
      'Keep movement clear',
    ]),
    'mistakes': _asBulletText([
      'No movement',
      'Wrong shape',
      'Using whole hand',
    ]),
  },
};
