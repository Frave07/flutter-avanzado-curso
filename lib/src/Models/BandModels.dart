
class BandModels
{
    String id;
    String nombre;
    int votos;

    BandModels({
      this.id,
      this.nombre,
      this.votos
    });

    factory BandModels.fromMap( Map<String, dynamic> obj ) => BandModels(
        id: obj['id'],
        nombre: obj['nombre'],
        votos: obj['votos']
    );
}