const gameCards = [
  GameCard(
    imagePath: 'assets/images/cards/zoli.png',
    name: 'Zoli',
    role: 'CEO',
  ),
  GameCard(
    imagePath: 'assets/images/cards/mesi.png',
    name: 'Mesi',
    role: 'People Mgr.',
  ),
  GameCard(
    imagePath: 'assets/images/cards/laci.png',
    name: 'Laci',
    role: 'Mobile',
  ),
  GameCard(
    imagePath: 'assets/images/cards/fruzsi.png',
    name: 'Fruzsi',
    role: 'Marketing',
  ),
  GameCard(
    imagePath: 'assets/images/cards/andris.png',
    name: 'Andris',
    role: 'Full Stack',
  ),
  GameCard(
    imagePath: 'assets/images/cards/szabina.png',
    name: 'Szabina',
    role: 'Frontend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/imi.png',
    name: 'Imi',
    role: 'Frontend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/dani.png',
    name: 'Dani',
    role: 'Frontend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/kovacsimi.png',
    name: 'Imi',
    role: 'Business Dev. Mgr.',
  ),
  GameCard(
    imagePath: 'assets/images/cards/dominik.png',
    name: 'Dominik',
    role: 'Backend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/barbi.png',
    name: 'Barbi',
    role: 'Office Mgr.',
  ),
  GameCard(
    imagePath: 'assets/images/cards/balazs.png',
    name: 'Balázs',
    role: 'Full Stack',
  ),
  GameCard(
    imagePath: 'assets/images/cards/mark.png',
    name: 'Márk',
    role: 'Frontend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/istvan.png',
    name: 'István',
    role: 'Backend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/jani.png',
    name: 'Jani',
    role: 'CFO',
  ),
  GameCard(
    imagePath: 'assets/images/cards/misi.png',
    name: 'Misi',
    role: 'Business Analyst',
  ),
  GameCard(
    imagePath: 'assets/images/cards/szabi.png',
    name: 'Szabi',
    role: 'Backend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/mario.png',
    name: 'Márió',
    role: 'Full Stack',
  ),
  GameCard(
    imagePath: 'assets/images/cards/robi.png',
    name: 'Robi',
    role: 'Backend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/archy.png',
    name: 'Archy',
    role: 'Backend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/pali.png',
    name: 'Pali',
    role: 'Backend',
  ),
  GameCard(
    imagePath: 'assets/images/cards/adam.png',
    name: 'Ádám',
    role: 'Business Analyst',
  ),
  GameCard(
    imagePath: 'assets/images/cards/norbi.png',
    name: 'Norbi',
    role: 'Frontend',
  ),
];

class GameCard {
  const GameCard({
    required this.imagePath,
    required this.name,
    required this.role,
  });

  final String imagePath;
  final String name;
  final String role;
}
