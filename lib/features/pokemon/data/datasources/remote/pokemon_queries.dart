abstract class PokemonQueries {
  PokemonQueries._();

  static const String getReferenceDataOp = 'GetReferenceData';
  static const String getPokemonPageOp = 'GetPokemonPage';
  static const String getPokemonCountOp = 'GetPokemonCount';
  static const String getPokemonDetailOp = 'GetPokemonDetail';

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

  static const String getPokemonDetail = r'''
    query GetPokemonDetail($id: Int!) {
      pokemon(where: {id: {_eq: $id}}) {
        id
        pokemonabilities(order_by: {slot: asc}) {
          slot
          is_hidden
          ability {
            id
            name
            abilitynames(where: {language_id: {_eq: 7}}) { name }
            abilityeffecttexts(where: {language_id: {_eq: 9}}) { short_effect }
            abilityflavortexts(
              where: {language_id: {_eq: 7}}
              order_by: {version_group_id: desc}
              limit: 1
            ) { flavor_text }
          }
        }
        pokemonmoves {
          version_group_id
          level
          movelearnmethod { name }
          move {
            id
            name
            type_id
            power
            accuracy
            pp
            movedamageclass { name }
            movenames(where: {language_id: {_eq: 7}}) { name }
          }
        }
        pokemonspecy {
          id
          pokemonegggroups { egg_group_id }
          evolutionchain {
            pokemonspecies(order_by: {id: asc}) {
              id
              name
              generation_id
              evolution_chain_id
              evolves_from_species_id
              pokemonevolutions {
                id
                min_level
                min_happiness
                time_of_day
                evolutiontrigger { name }
                item { name }
              }
            }
          }
        }
      }
    }
  ''';
}
