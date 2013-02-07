{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Data.Thyme.Clock (
    -- * Universal Time
      UniversalTime
    , modJulianDate

    -- * Absolute intervals
    , DiffTime
    , microDiffTime

    -- * UTC
    , UTCTime, UTCView (..)
    , utcTime
    , NominalDiffTime
    , microNominalDiffTime
    , module Data.Thyme.Clock

    -- * Lenses
    , _utctDay, _utctDayTime
    ) where

import Prelude
import Control.Lens
import Data.Thyme.Clock.Internal
import Data.Thyme.Clock.POSIX
#if !SHOW_INTERNAL
import Data.Thyme.LocalTime.Internal
import Data.Thyme.LocalTime.TimeZone
#endif

#if SHOW_INTERNAL
instance Show UTCTime where
    showsPrec p = showsPrec p . view utcTime
#else
instance Show UTCTime where
    showsPrec p = showsPrec p . view zonedTime . (,) utc
#endif

getCurrentTime :: IO UTCTime
getCurrentTime = fmap (review posixTime) getPOSIXTime

