module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background exposing (..)
import Element.Border exposing (rounded)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Events exposing (..)
import Json.Decode as D


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


defaultTotal =
    480


defaultHours =
    10


defaultCostPerMonth =
    2000


type alias Model =
    { hoursPerMonth : Int
    , config : Flags
    }


type alias Flags =
    { costPerMonth : Maybe Int
    , totalNumberOfHours : Maybe Int
    }


type Msg
    = HoursChanged Float


flagsDecoder : D.Decoder Flags
flagsDecoder =
    D.map2 Flags (D.maybe (D.field "costPerMonth" D.int)) (D.maybe (D.field "totalNumberOfHour" D.int))


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { hoursPerMonth = defaultHours
      , config = flags
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HoursChanged hours ->
            ( { model | hoursPerMonth = round hours }, Cmd.none )


renderTotal : String -> Int -> Element Msg
renderTotal label number =
    wrappedRow []
        [ el [ Font.bold ] <| text (String.fromInt number)
        , el [] <| text (" " ++ label)
        ]


renderSlider : Int -> Element Msg
renderSlider hours =
    Input.slider
        [ Element.height (Element.px 30)

        -- Here is where we're creating/styling the "track"
        , Element.behindContent
            (Element.el
                [ Element.width Element.fill
                , Element.height (Element.px 2)
                , Element.centerY
                , Element.Background.color (rgb255 52 101 164)
                , Element.Border.rounded 2
                ]
                Element.none
            )
        ]
        { min = defaultHours
        , max = 60
        , label = Input.labelAbove [] (text (String.fromInt hours ++ " hours worked per week"))
        , onChange = HoursChanged
        , value = toFloat hours
        , step = Just 1
        , thumb = Input.defaultThumb
        }


headingStyle =
    [ Font.bold, Font.underline, width fill ]


costPerMonth : Model -> Int
costPerMonth =
    Maybe.withDefault defaultCostPerMonth
        << .costPerMonth
        << .config


total : Model -> Int
total =
    Maybe.withDefault defaultTotal
        << .totalNumberOfHours
        << .config


view : Model -> Html Msg
view model =
    let
        hours =
            model.hoursPerMonth

        totalWeeks =
            total model // model.hoursPerMonth

        totalMonth =
            totalWeeks // 4

        totalCost =
            costPerMonth model * totalMonth
    in
    layout
        [ padding 10
        ]
    <|
        column [ width fill, spacingXY 0 20 ]
            [ el [ centerX ] <|
                text "Program Cost Calculator"
            , renderSlider hours
            , paragraph headingStyle [ text "How long will it take to learn how to build my project?" ]
            , renderTotal "weeks" totalWeeks
            , renderTotal "months approximately" totalMonth
            , paragraph headingStyle [ text "How much will it cost?" ]
            , el [] <| text ("$" ++ " " ++ String.fromInt totalCost)
            ]
