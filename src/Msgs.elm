module Msgs exposing (..)

import Http
import Models exposing (Player, PlayerForm)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | PostPlayerForm
    | OnPlayerCreate (Result Http.Error Player)
    | ChangePlayerFormName String
    | ChangePlayerFormLevel PlayerForm Int
