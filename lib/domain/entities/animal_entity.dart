import '../../app/theme/icons.dart';

class AnimalEntity {
  String id;

  String title;

  String icon;

  String type;

  String name;

  AnimalEntity(
      {required this.id,
      required this.title,
      required this.icon,
      required this.type,
      required this.name});

  static List<AnimalEntity> defaultAnimalList = [
    AnimalEntity(
      id: "animal_1",
      title: "Dragon",
      icon: AppIcons.icDragon,
      type:
          "https://drive.google.com/uc?id=1L7dO0MQOA8HvhFKuwjlOGsex7NmmIj11&export=download",
      name: "Dragon",
    ),
    AnimalEntity(
      id: "animal_2",
      title: "Wolf",
      icon: AppIcons.icWolf,
      type:
          "https://drive.google.com/uc?id=1L7dO0MQOA8HvhFKuwjlOGsex7NmmIj11&export=download",
      name: "Wolf",
    ),
    AnimalEntity(
      id: "animal_3",
      title: "Shark",
      icon: AppIcons.icShark,
      type:
          "https://drive.google.com/uc?id=1DC2Ez1KVSOBSrMyGDa2Q8aoWdyArKfsp&export=download",
      name: "Shark",
    ),
    AnimalEntity(
      id: "animal_4",
      title: "Dinosaur",
      icon: AppIcons.icTyrannosaurus,
      type:
          "https://drive.google.com/uc?id=1b4ZpjNt__RaJl-ebLSChnkoVdh20p85f&export=download",
      name: "Dinosaur",
    ),
    AnimalEntity(
      id: "animal_5",
      title: "AngelFish",
      icon: AppIcons.icAngleFish,
      type:
          "https://drive.google.com/uc?id=1pnctRQiFSijnNmefxRSGsKT03ieaVIYr&export=download",
      name: "AngelFish",
    ),
    AnimalEntity(
      id: "animal_6",
      title: "Atolla",
      icon: AppIcons.icAngleFish,
      type:
          "https://drive.google.com/uc?id=1KKrwNUEMfcNpwiEq0owo_fyHkA2ZIDN7&export=download",
      name: "Atolla",
    ),
    AnimalEntity(
      id: "animal_7",
      title: "Baby_Turtule",
      icon: AppIcons.icAngleFish,
      type:
          "https://drive.google.com/uc?id=1-CZu1dsofprFBz9glRKjYWT2exzPFsWq&export=download",
      name: "Baby_Turtule",
    ),
    AnimalEntity(
      id: "animal_8",
      title: "BackwedgedButterflyfish",
      icon: AppIcons.icAngleFish,
      type:
          "https://drive.google.com/uc?id=1MExzBmHfgm6GczhoxA60GNDiQad1Evtz&export=download",
      name: "BackwedgedButterflyfish",
    )
  ];
}
