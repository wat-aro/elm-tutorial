module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Models exposing (Player, PlayerForm, PlayerId)
import Msgs exposing (Msg)
import RemoteData


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:4000/players"


playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "level" Decode.int


playersUrl : String
playersUrl =
    "http://localhost:4000/players/"


savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
    playersUrl ++ toString playerId


savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


createPlayerRequest : PlayerForm -> Http.Request Player
createPlayerRequest playerForm =
    Http.request
        { body = playerFormEncoder playerForm |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = playersUrl
        , withCredentials = False
        }


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPlayerSave


createPlayerCmd : PlayerForm -> Cmd Msg
createPlayerCmd playerForm =
    createPlayerRequest playerForm
        |> Http.send Msgs.OnPlayerCreate


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.int player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
    Encode.object attributes


playerFormEncoder : PlayerForm -> Encode.Value
playerFormEncoder playerForm =
    let
        attributes =
            [ ( "name", Encode.string playerForm.name )
            , ( "level", Encode.int playerForm.level )
            ]
    in
    Encode.object attributes
