module Tests exposing (..)

import Calculations exposing (baseDuration, filesize, fullDuration, reelLengthInFeet)
import Expect
import Helpers exposing (newReel)
import Random.Pcg exposing (initialSeed, step)
import Test exposing (..)
import Types exposing (..)
import Uuid exposing (Uuid, uuidGenerator)


all : Test
all =
    describe "reel duration & file size calculation"
        [ describe "full-track mono, 5\" 0.5mil triple @ 3.75 IPS" <|
            let
                reel =
                    newReel fakeUUID (SelectorValues FullTrackMono Five Mil0p5Triple IPS_3p75) 1
            in
            [ test "should be 1 pass" <|
                \_ ->
                    Expect.equal reel.passes 1
            , test "reel footage should be 1800ft" <|
                let
                    footage =
                        reelLengthInFeet reel
                in
                \_ -> Expect.equal footage Ft1800
            , test "duration should be 90 minutes" <|
                let
                    duration =
                        fullDuration reel
                in
                \_ -> Expect.equal duration 90
            , test "should be 1518.75 MB in size" <|
                let
                    size =
                        filesize reel
                in
                \_ -> Expect.equal size 1518.75
            ]
        , describe "half-track stereo, 10.5\" 0.5mil double @ 7.5 IPS" <|
            let
                reel =
                    newReel fakeUUID (SelectorValues HalfTrackStereo TenPtFive Mil0p5Double IPS_7p5) 1
            in
            [ test "should be 1 pass" <|
                \_ ->
                    Expect.equal reel.passes 1
            , test "reel footage should be 4800ft" <|
                let
                    footage =
                        reelLengthInFeet reel
                in
                \_ -> Expect.equal footage Ft4800
            , test "duration should be 120 minutes" <|
                let
                    duration =
                        fullDuration reel
                in
                \_ -> Expect.equal duration 120
            , test "should be 4050 MB in size" <|
                let
                    size =
                        filesize reel
                in
                \_ -> Expect.equal size 4050
            ]
        , describe "half-track mono, 7\" 1.5mil @ 1.875 IPS" <|
            let
                reel =
                    newReel fakeUUID (SelectorValues HalfTrackMono Seven Mil1p5 IPS_1p875) 1
            in
            [ test "should be 2 passes" <|
                \_ ->
                    Expect.equal reel.passes 2
            , test "reel footage should be 1200ft" <|
                let
                    footage =
                        reelLengthInFeet reel
                in
                \_ -> Expect.equal footage Ft1200
            , test "duration should be 240 minutes" <|
                let
                    duration =
                        fullDuration reel
                in
                \_ -> Expect.equal duration 240
            , test "should be 4050 MB in size" <|
                let
                    size =
                        filesize reel
                in
                \_ -> Expect.equal size 4050
            ]
        , describe "quarter-track stereo, 10.5\" 0.5mil triple @ 30 IPS" <|
            let
                reel =
                    newReel fakeUUID (SelectorValues QuarterTrackStereo TenPtFive Mil0p5Triple IPS_30) 1
            in
            [ test "should be 2 passes" <|
                \_ ->
                    Expect.equal reel.passes 2
            , test "reel footage should be 7200ft" <|
                let
                    footage =
                        reelLengthInFeet reel
                in
                \_ -> Expect.equal footage Ft7200
            , test "duration should be 90 minutes" <|
                let
                    duration =
                        fullDuration reel
                in
                \_ -> Expect.equal duration 90
            , test "should be 3037.5 MB in size" <|
                let
                    size =
                        filesize reel
                in
                \_ -> Expect.equal size 3037.5
            ]
        , describe "quarter-track mono, 7\" 1.0mil @ 15 IPS" <|
            let
                reel =
                    newReel fakeUUID (SelectorValues QuarterTrackMono Seven Mil1p0 IPS_15) 1
            in
            [ test "should be 4 passes" <|
                \_ ->
                    Expect.equal reel.passes 4
            , test "reel footage should be 1800ft" <|
                let
                    footage =
                        reelLengthInFeet reel
                in
                \_ -> Expect.equal footage Ft1800
            , test "duration should be 90 minutes" <|
                let
                    duration =
                        fullDuration reel
                in
                \_ -> Expect.equal duration 90
            , test "should be 1518.75 MB in size" <|
                let
                    size =
                        filesize reel
                in
                \_ -> Expect.equal size 1518.75
            ]
        ]


fakeUUID : Uuid
fakeUUID =
    let
        ( uuid, seed ) =
            step uuidGenerator (initialSeed 1234567)
    in
    uuid
