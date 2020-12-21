
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
        id     : obj.containsKey('id') ? obj['id'] : 'no-id',
        nombre : obj.containsKey('nombre') ? obj['nombre'] : 'no-nombre',
        votos  : obj.containsKey('votos') ? obj['votos'] : 'no-votos'
    );
}