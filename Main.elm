module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Random
import List.Extra exposing (getAt)
import Maybe exposing (withDefault)


-- MODEL


type alias Model =
    { author : String
    , quote : String
    }


model : Model
model =
    { author = "", quote = "" }


init : ( Model, Cmd Msg )
init =
    ( { author = "Adam", quote = "All things" }, Cmd.none )


defaultQuote : Model
defaultQuote =
    { author = "Default author", quote = "Default quote" }


quotes : List Model
quotes =
    [ { author = "Adam", quote = "Some things" }
    , { author = "Joe", quote = "Some other things" }
    , { author = "John", quote = "Some other other things" }
    , { author = "Jacob", quote = "Good things" }
    ]



-- UPDATE


type Msg
    = NoOp
    | FetchQuote
    | RandomNumber Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchQuote ->
            ( model, Random.generate RandomNumber (Random.int 0 3) )

        RandomNumber int ->
            ( withDefault defaultQuote (getAt int quotes), Cmd.none )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.author ]
        , div [] [ text model.quote ]
        , button [ onClick FetchQuote ] [ text "Fetch new quote" ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
