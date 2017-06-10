module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (..)


main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Model =
    { name : String
    , country : String
    , sliderOne : String
    , sliderTwo : String
    , location : String
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model "" "" "5" "5" location.hash, Cmd.none )


type Msg
    = UpdateName String
    | UpdateCountry String
    | UpdateSliderOne String
    | UpdateSliderTwo String
    | FirstPageSubmit
    | SecondPageSubmit
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateName newName ->
            ( { model | name = newName }, Cmd.none )

        UpdateCountry newCountry ->
            ( { model | country = newCountry }, Cmd.none )

        UpdateSliderOne newValOne ->
            ( { model | sliderOne = newValOne }, Cmd.none )

        UpdateSliderTwo newValTwo ->
            ( { model | sliderTwo = newValTwo }, Cmd.none )

        FirstPageSubmit ->
            ( model, Navigation.newUrl "#/second-view" )

        SecondPageSubmit ->
            ( model, Navigation.newUrl "/" )

        UrlChange newLocation ->
            ( { model | location = newLocation.hash }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ selectView model
        ]


selectView : Model -> Html Msg
selectView model =
    case model.location of
        "" ->
            Html.form [ onSubmit FirstPageSubmit ]
                [ label [ for "name" ] [ text "Name" ]
                , input [ id "name", type_ "text", value model.name, onInput UpdateName, placeholder "name" ] []
                , label [ for "country" ] [ text "Country" ]
                , input [ id "country", type_ "text", value model.country, onInput UpdateCountry, placeholder "country" ] []
                , button [ type_ "submit" ] [ text "next" ]
                ]

        "#/second-view" ->
            Html.form [ onSubmit SecondPageSubmit ]
                [ label [ for "slider-one" ] [ text "Slider One" ]
                , input [ id "slider-one", type_ "range", Html.Attributes.max "10", Html.Attributes.min "0", step "1", value model.sliderOne, onInput UpdateSliderOne ] []
                , label [ for "slider-two" ] [ text "Slider Two" ]
                , input [ id "slider-two", type_ "range", Html.Attributes.max "10", Html.Attributes.min "0", step "1", value model.sliderTwo, onInput UpdateSliderTwo ] []
                , button [ type_ "submit" ] [ text "back" ]
                ]

        _ ->
            div [] [ text "how did you evne get here" ]
