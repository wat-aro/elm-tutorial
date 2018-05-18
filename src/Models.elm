module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , playerForm : PlayerForm
    , route : Route
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NewPlayerRoute
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , playerForm = newPlayerForm
    , route = route
    }


type alias PlayerId =
    Int


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type alias PlayerForm =
    { name : String
    , level : Int
    }


newPlayerForm : PlayerForm
newPlayerForm =
    { name = ""
    , level = 0
    }
