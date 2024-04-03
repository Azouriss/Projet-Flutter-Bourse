import 'package:flutter/material.dart';

class infoArticles extends StatefulWidget {
  const infoArticles({super.key});

  @override
  State<infoArticles> createState() => _infoArticlesState();
}

class Article {
  final String title;
  final String description;
  final String imagePath; // Chemin de l'image

  Article(this.title, this.description, this.imagePath);
}

class _infoArticlesState extends State<infoArticles> {
  @override
  Widget build(BuildContext context) {
    // Liste d'articles avec la nouvelle description pour l'article 3
    List<Article> articles = [
      Article(
          'La hausse des bourses est en contradiction avec l etat de l economie, selon Rosengren',
          'Comme de plus en plus d economistes de renom, David Rosengren a recemment souligne a quel point l etat de l economie et la hausse des marches sont en contradiction, ce qui suggerer un risque de retour de baton brutal. Dans une note publiee mardi, il a en effet estime que la derniere frenesie du marche ressemble a la periode de juillet 2007, lorsque les actions ont ete prises dans une chute rapide trois mois plus tard, jugeant que la frenesie qui alimente les gains est au-dela de l extreme. Selon lui, la hausse des bourses ne repose pas sur des fondamentaux economiques solides, deplorant un marche anime par l autosatisfaction, la cupidite et l elan. Plus precisement, Rosenberg note un manque de soutien des benefices, avec des estimations de benefices stagnantes depuis janvier. En outre, il affirme que l expansion des multiples boursiers n est pas justifiee etant donne l augmentation de 30 points de base du rendement du Tresor a 10 ans depuis le debut de l annee. Il a pointe du doigt a titre d exemple le fait que les actions du secteur de la vente au detail atteignent des sommets historiques alors que les volumes des ventes au detail ont baisse de 1,6 % le mois dernier.',
          'assets/article1.jpg'), // Chemin de l'image pour l'article 1
      Article(
          'L\'action du reseau social de Trump explose de 57% : "le nouveau BTC", ironise Schiff',
          'Le prix de l action de la societe de medias sociaux de Donald Trump ont termine la seance de mardi en hausse de plus de 16% a 57.99 dollars, apres avoir gagne plus de 50% a un moment de la journee, le titre ayant marque un pic intraday a 76.2 dollars. Notons que ce mouvement faisait suite a une hausse de 35.22% lundi, apres qu une cour d appel de New York a ramene de 454 millions de dollars a 175 millions de dollars le montant de la caution que M. Trump devrait deposer pour suspendre le recouvrement d une condamnation pour fraude commerciale pendant qu il fait appel de l affaire. Au total, l action a progresse de 57% sur les deux dernieres seances. Elle reste cependant loin du sommet de 175 dollars qui avait ete atteint lorsque Digital World Acquisition a annonce son intention de fusionner avec la societe de medias sociaux deTrump en octobre 2021. En ce qui concerne la hausse d hier, on notera qu elle faisait suite au changement de ticker de la SPAC Digital World Acquisition Corp (DWAC) suite a la finalisation de la fusion avec Trump Media & Technology Group Corp (NASDAQ:DJT), pour desormais se negocier sous la denomination DJT.',
          'assets/article2.jpg'), // Chemin de l'image pour l'article 2
      Article(
        // Nouveau titre pour l'article 3
          'H&M: Le bénéfice d exploitation augmente plus que prévu au 1er trimestre',
          // Nouvelle description pour l'article 3
          'Le deuxieme plus grand distributeur de mode cote au monde, a fait etat mercredi d un benefice d exploitation superieur aux attentes pour la periode decembre-fevrier. Le benefice d exploitation du premier trimestre de l exercice fiscal du groupe, s est eleve a 2,08 milliards de couronnes (181,36 millions d euros), contre 725 millions un an plus tot, depassant la prevision moyenne des analystes qui tablaient sur 1,43 milliard de couronnes. H&M a dit viser un benefice d exploitation de 10% au cours de cette annee. Mesurees en devises locales, les ventes de H&M entre le 1er et le 25 mars ont augmente de 2%, a indique le groupe. (Reportage Marie Mannes a Stockholm et Helen Reid a Londres ; version francaise Lina Golovnya, edite par Zhifan Liu)',
          'assets/article3.jpg'), // Chemin de l'image pour l'article 3
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black, // Couleur principale
        textTheme: const TextTheme(
          headline6: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold), // Style du titre
          subtitle1: TextStyle(color: Colors.grey), // Style du sous-titre
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: const Text(
            'Articles',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: articles.length, // Utilisation de la longueur de la liste d'articles
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      width: double.infinity,
                      height: 150,
                      child: Image.asset(articles[index].imagePath, fit: BoxFit.cover), // Charger l'image correspondant à l'article
                    ),
                    ListTile(
                      leading: Icon(Icons.article,
                          color: Theme.of(context).primaryColor),
                      title: Text(
                        articles[index].title, // Affichage du titre de l'article
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        articles[index].description, // Affichage de la description de l'article
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
