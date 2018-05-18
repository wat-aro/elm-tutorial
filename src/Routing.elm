module Routing exposing (..)

import Models exposing (PlayerId, Route(..))
import Navigation exposing (Location)
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map NewPlayerRoute (s "players" </> s "new")
        , map PlayerRoute (s "players" </> int)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


playersPath : String
playersPath =
    "#players"


playerPath : PlayerId -> String
playerPath id =
    "#players/" ++ toString id


newPlayerPath : String
newPlayerPath =
    "#players/new"
