module Update exposing (Msg(..), update)

import Helpers exposing (..)
import Model exposing (Model)
import Random.Pcg exposing (step)
import Translate exposing (Language(..))
import Types exposing (..)
import Uuid exposing (Uuid, uuidGenerator)


type Msg
    = AddReel
    | DeleteRow Reel
    | ChangeAudioConfig String
    | ChangeDiameterInInches String
    | ChangeTapeThickness String
    | ChangeRecordingSpeed String
    | UpdateQuantity String
    | ChangeSystemOfMeasurement SystemOfMeasurement
    | ChangeLanguage Language
    | TogglePageView PageView
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddReel ->
            case model.quantity of
                Just q ->
                    let
                        ( uuid, newSeed ) =
                            step uuidGenerator model.currentSeed

                        newReels =
                            [ newReel uuid model.selectorValues q ] ++ model.reels

                        newModel =
                            { model | currentSeed = newSeed, reels = newReels }
                    in
                    ( newModel, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        DeleteRow reel ->
            let
                newReels =
                    List.filter (\r -> r.id /= reel.id) model.reels

                newModel =
                    { model | reels = newReels }
            in
            ( newModel, Cmd.none )

        ChangeAudioConfig str ->
            case audioConfigFromString str of
                Just config ->
                    let
                        updateSValues sValues newConfig =
                            { sValues | audioConfig = newConfig }

                        newSelectorValues =
                            updateSValues model.selectorValues config

                        newModel =
                            { model | selectorValues = newSelectorValues }
                    in
                    ( newModel, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        ChangeDiameterInInches str ->
            case diameterFromString str of
                Just diameter ->
                    let
                        updateSValues sValues newDiameterInInches =
                            { sValues | diameter = newDiameterInInches }

                        newSelectorValues =
                            updateSValues model.selectorValues diameter

                        newModel =
                            { model | selectorValues = newSelectorValues }
                    in
                    ( newModel, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        ChangeTapeThickness str ->
            case tapeThicknessFromString str of
                Just thickness ->
                    let
                        updateSValues sValues newThickness =
                            { sValues | tapeThickness = newThickness }

                        newSelectorValues =
                            updateSValues model.selectorValues thickness

                        newModel =
                            { model | selectorValues = newSelectorValues }
                    in
                    ( newModel, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        ChangeRecordingSpeed str ->
            case recordingSpeedFromString str of
                Just speed ->
                    let
                        updateSValues sValues newSpeed =
                            { sValues | recordingSpeed = newSpeed }

                        newSelectorValues =
                            updateSValues model.selectorValues speed

                        newModel =
                            { model | selectorValues = newSelectorValues }
                    in
                    ( newModel, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        UpdateQuantity quantity ->
            case String.toInt quantity of
                Ok q ->
                    ( { model | quantity = Just q }, Cmd.none )

                Err e ->
                    ( { model | quantity = Nothing }, Cmd.none )

        ChangeSystemOfMeasurement system ->
            case system of
                Metric ->
                    ( { model | system = Metric }, Cmd.none )

                Imperial ->
                    ( { model | system = Imperial }, Cmd.none )

        ChangeLanguage l ->
            ( { model | language = l }, Cmd.none )

        TogglePageView page ->
            case page of
                Calculator ->
                    ( { model | page = Info }, Cmd.none )

                Info ->
                    ( { model | page = Calculator }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
