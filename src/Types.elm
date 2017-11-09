module Types exposing (..)

import Uuid exposing (Uuid)


type alias ReelEntry =
    { id : Uuid.Uuid
    , audioConfig : AudioConfig
    , diameter : Diameter
    , thickness : TapeThickness
    , recordingSpeed : RecordingSpeed
    , quantity : Int
    }


type alias SelectorValues =
    { audioConfig : AudioConfig
    , diameter : Diameter
    , thickness : TapeThickness
    , recordingSpeed : RecordingSpeed
    }


type AudioConfig
    = FullTrackMono
    | HalfTrackStereo
    | HalfTrackMono
    | QuarterTrackStereo
    | QuarterTrackMono


allAudioConfigs : List AudioConfig
allAudioConfigs =
    [ FullTrackMono, HalfTrackStereo, HalfTrackMono, QuarterTrackStereo, QuarterTrackMono ]


type Diameter
    = Five
    | Seven
    | TenPtFive


allDiameters : List Diameter
allDiameters =
    [ Five, Seven, TenPtFive ]


type TapeThickness
    = Mil1p5
    | Mil1p0
    | Mil0p5Double
    | Mil0p5Triple


allThicknesses : List TapeThickness
allThicknesses =
    [ Mil1p5, Mil1p0, Mil0p5Double, Mil0p5Triple ]


type RecordingSpeed
    = IPS_1p875
    | IPS_3p75
    | IPS_7p5
    | IPS_15
    | IPS_30


allRecordingSpeeds : List RecordingSpeed
allRecordingSpeeds =
    [ IPS_1p875, IPS_3p75, IPS_7p5, IPS_15, IPS_30 ]
