module Players.New exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)
import Models exposing (PlayerForm)
import Msgs exposing (Msg)
import Routing exposing (playersPath)


view : PlayerForm -> Html Msg
view model =
    div []
        [ nav model
        , form model
        , createBtn model
        ]


nav : PlayerForm -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : PlayerForm -> Html Msg
form playerForm =
    div [ class "m3" ]
        [ h1 [] [ text "Name" ]
        , input [ type_ "text", placeholder "Name", onInput Msgs.ChangePlayerFormName ] []
        , formLevel playerForm
        ]


formLevel : PlayerForm -> Html Msg
formLevel playerForm =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 hold" ] [ text <| toString playerForm.level ]
            , btnLevelDecrease playerForm
            , btnLevelIncrease playerForm
            ]
        ]


btnLevelDecrease : PlayerForm -> Html Msg
btnLevelDecrease playerForm =
    let
        message =
            Msgs.ChangePlayerFormLevel playerForm -1
    in
    a [ class "btn ml1 h1", onClick message ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : PlayerForm -> Html Msg
btnLevelIncrease playerForm =
    let
        message =
            Msgs.ChangePlayerFormLevel playerForm 1
    in
    a [ class "btn ml1 h1", onClick message ]
        [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]

createBtn : PlayerForm -> Html Msg
createBtn playerForm =
    a [ class "btn ml1 h3", onClick Msgs.PostPlayerForm ]
        [ i [class "fa fa-arrow-circle-right"] [text "Submit"]]
