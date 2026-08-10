package com.zodiak.android.feature.savekids.data.remote.retrofit

import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Url
import com.google.gson.annotations.SerializedName

data class NamedResourceDto(
    val name: String,
    val url: String,
)

data class PokemonSpritesDto(
    val front_default: String?,
    val other: PokemonOtherSpritesDto? = null,
)

data class PokemonOtherSpritesDto(
    @SerializedName("official-artwork")
    val officialArtwork: PokemonOfficialArtworkDto? = null,
)

data class PokemonOfficialArtworkDto(
    val front_default: String?,
)

data class PokemonTypeWrapperDto(
    val type: NamedResourceDto,
)

data class PokemonDto(
    val id: Int,
    val name: String,
    val sprites: PokemonSpritesDto,
    val types: List<PokemonTypeWrapperDto>,
)

data class EvolutionChainReferenceDto(
    val url: String,
)

data class PokemonSpeciesDto(
    val evolution_chain: EvolutionChainReferenceDto,
)

data class EvolutionChainDto(
    val chain: EvolutionNodeDto,
)

data class EvolutionNodeDto(
    val species: NamedResourceDto,
    val evolves_to: List<EvolutionNodeDto>,
)

interface PokeApiService {
    @GET("pokemon/{id}")
    suspend fun getPokemon(@Path("id") id: Int): PokemonDto

    @GET("pokemon/{name}")
    suspend fun getPokemonByName(@Path("name") name: String): PokemonDto

    @GET("pokemon-species/{id}")
    suspend fun getPokemonSpecies(@Path("id") id: Int): PokemonSpeciesDto

    @GET
    suspend fun getEvolutionChainByUrl(@Url url: String): EvolutionChainDto
}
