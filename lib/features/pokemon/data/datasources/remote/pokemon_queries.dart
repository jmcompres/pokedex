abstract class PokemonQueries {
  PokemonQueries._();

  static const String getReferenceDataOp = 'GetReferenceData';
  static const String getPokemonPageOp = 'GetPokemonPage';
  static const String getPokemonCountOp = 'GetPokemonCount';

  static const String getReferenceData = r''' 
    query GetReferenceData {
      type(order_by: {id: asc}) {
        id
        name
        typenames(where: {language_id: {_eq: 7}}){
          name
        }
      }
      typeefficacy {
        damage_factor
        damage_type_id
        target_type_id
      }
      generation(order_by: {id: asc}) {
        id
        name
        region {
          name
        }
      }
      versiongroup(order_by: {id: asc}) {
        id
        name
        generation_id
        order
      }
      egggroup(order_by: {id: asc}) {
        id
        name
        egggroupnames(where: {language_id: {_eq: 7}}){
          name
        }
      }
    }
  ''';

  static const String getPokemonPage = r'''
    query GetPokemonPage($limit: Int!, $offset: Int!) {
      pokemon(limit: $limit, offset: $offset, order_by: {id: asc}){
        id
        name
        is_default
        height
        weight
        pokemonspecy {
          id
          name
          generation_id
          evolution_chain_id
        }
        pokemonforms(order_by: {form_order: asc}) {
          id
          name
          form_name
          is_default
          is_mega
          is_battle_only
          form_order
        }
        pokemontypes(order_by: {slot: asc}) {
          slot
          type_id
        }
        pokemonstats {
          base_stat
          stat{
            name
          }
        }
        pokemonsprites {
          sprites
        }
      }
    }
  ''';

  static const String getPokemonCount = r'''
    query GetPokemonCount {
      pokemon_aggregate {
        aggregate {
          count
        }
      }
    }
  ''';
}
