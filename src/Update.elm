module Update exposing (..)

import Commands exposing (savePlayerCmd)
import Models exposing (Model, Player, PlayerForm)
import Msgs exposing (Msg(..))
import RemoteData
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.ChangePlayerFormName name ->
            ( updatePlayerFormName model name, Cmd.none )

        Msgs.ChangePlayerFormLevel playerForm level ->
            ( updatePlayerFormLevel model playerForm level, Cmd.none )

        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
            ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
    { model | players = updatedPlayers }


updatePlayerFormName : Model -> String -> Model
updatePlayerFormName model str =
    let
        currentPlayerForm =
            model.playerForm

        updatedPlayerForm =
            { currentPlayerForm | name = str }
    in
    { model | playerForm = updatedPlayerForm }


updatePlayerFormLevel : Model -> PlayerForm -> Int -> Model
updatePlayerFormLevel model playerForm level =
    let
        updatedPlayerForm =
            { playerForm | level = playerForm.level + level }
    in
    { model | playerForm = updatedPlayerForm }
